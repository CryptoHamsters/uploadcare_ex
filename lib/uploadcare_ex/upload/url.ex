defmodule UploadcareEx.Upload.Url do
  alias UploadcareEx.Request
  alias UploadcareEx.Config

  @base_url "https://upload.uploadcare.com/from_url/"

  @spec upload(binary()) :: {:ok, map()} | {:error, Request.response()}
  def upload(url) do
    with {:ok, token} <- url |> try_to_upload(),
         {:ok, result} <- token |> check_token_status() do
      {:ok, result}
    end
  end

  @spec try_to_upload(binary()) :: {:ok, binary()} | {:error, Request.response()}
  def try_to_upload(url) do
    url_with_params = url |> upload_url()

    case url_with_params |> Request.request(:get) do
      %{status_code: 200, body: %{"token" => token}} -> {:ok, token}
      other -> {:error, other}
    end
  end

  @spec check_token_status(binary()) :: {:ok, map()} | {:error, Request.response()}
  def check_token_status(token) do
    url = token |> status_url()

    case url |> Request.request(:get) do
      %{status_code: 200, body: %{"status" => "success"} = resp} -> {:ok, resp}
      other -> {:error, other}
    end
  end

  @spec upload_url(binary()) :: binary()
  defp upload_url(url) do
    params = url |> upload_params()

    @base_url <> "?#{params}"
  end

  @spec status_url(binary()) :: binary()
  defp status_url(token) do
    @base_url <> "status/?token=#{token}"
  end

  @spec upload_params(binary()) :: binary()
  defp upload_params(url) do
    [
      pub_key: Config.public_key(),
      source_url: url
    ]
    |> URI.encode_query()
  end
end
