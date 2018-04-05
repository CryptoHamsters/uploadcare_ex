defmodule UploadcareEx.API.Upload.Url do
  import UploadcareEx.API.Urls

  @moduledoc false

  alias UploadcareEx.{Request, Config}

  @spec upload(binary()) :: {:ok, map()} | {:error, any()}
  def upload(url) do
    with {:ok, token} <- url |> try_to_upload(),
         {:ok, result} <- token |> check_token_status() do
      {:ok, result}
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

    case url |> Request.request(:get) do
      {:ok, %{status_code: 200, body: %{"status" => "success"} = resp}} -> {:ok, resp}
      {:ok, response} -> {:error, response}
      other -> other
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
