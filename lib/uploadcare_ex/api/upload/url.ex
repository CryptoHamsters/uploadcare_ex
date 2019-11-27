defmodule UploadcareEx.API.Upload.Url do
  use Retry

  import UploadcareEx.API.Urls
  require Logger

  @moduledoc false

  alias UploadcareEx.{Request, Config}

  @spec upload(binary()) :: {:ok, map()} | {:error, any()}
  def upload(url) do
    with {:ok, token} <- url |> try_to_upload(),
         {:ok, _result} <- token |> check_token_status() do
      {:ok, token}
    end
  end

  @spec try_to_upload(binary()) :: {:ok, binary()} | {:error, any()}
  def try_to_upload(url) do
    url_with_params = url |> base_upload_url()

    case url_with_params |> Request.request(:get) do
      {:ok, %{body: %{"token" => token}, status_code: 200}} -> {:ok, token}
      {:ok, response} -> {:error, response}
      other -> other
    end
  end

  @spec check_token_status(binary()) :: {:ok, map()} | {:error, Request.response()}
  def check_token_status(token) do
    url = token |> status_url()
    retry_period = Config.upload_url_retry_period()
    retry_expiry = Config.upload_url_retry_expiry()

    retry_while with: exp_backoff() |> randomize() |> cap(retry_period) |> expiry(retry_expiry) do
      case url |> Request.request(:get) do
        {:ok, %{status_code: 200, body: %{"status" => "success"} = resp}} ->
          {:halt, {:ok, resp}}

        # retry status check with delay when upload still in progress
        {:ok, %{status_code: 200, body: %{"status" => status}} = resp}
        when status in ["unknown", "progress"] ->
          {:cont, {:error, resp}}

        other ->
          {:halt, other}
      end
    end
  end

  @spec base_upload_url(binary()) :: binary()
  defp base_upload_url(url) do
    params = url |> upload_params()

    base_url() <> "?#{params}"
  end

  @spec status_url(binary()) :: binary()
  defp status_url(token) do
    base_url() <> "status/?token=#{token}"
  end

  @spec base_url() :: binary()
  defp base_url do
    upload_url() <> "/from_url/"
  end

  @spec upload_params(binary()) :: binary()
  defp upload_params(url) do
    [
      pub_key: Config.public_key(),
      source_url: url,
      store: Config.store()
    ]
    |> URI.encode_query()
  end
end
