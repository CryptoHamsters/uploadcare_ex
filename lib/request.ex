defmodule UploadcareEx.Request do
  alias UploadcareEx.Auth

  @type response :: %{status_code: number(), body: map() | binary()}

  @spec request(binary(), atom(), any(), map()) :: response()
  def request(url, http_method, data \\ "", headers \\ %{}) do
    with {
           :ok,
           %HTTPoison.Response{
             status_code: code,
             body: body
           }
         } <- HTTPoison.request(http_method, url, data, headers) do
      %{status_code: code, body: body |> Poison.decode!()}
    end
  end
end
