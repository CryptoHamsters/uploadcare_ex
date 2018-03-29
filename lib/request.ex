defmodule UploadcareEx.Request do
  alias UploadcareEx.Auth

  @base_url "https://api.uploadcare.com/"

  def request(path, http_method, data, headers \\ %{}) do
    url = path |> request_url()
    headers_with_auth = headers |> authorize_headers()

    HTTPoison.request(http_method, url, data, headers_with_auth)
  end

  @spec request_url(binary()) :: binary()
  defp request_url(path) do
    @base_url <> path
  end

  @spec authorize_headers(map()) :: map()
  defp authorize_headers(headers) do
    headers |> Map.merge(auth_headers())
  end

  @spec auth_headers() :: map()
  defp auth_headers do
    Auth.simple_auth_headers()
  end
end
