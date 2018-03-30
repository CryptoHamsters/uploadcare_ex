defmodule UploadcareEx.Request do
  alias UploadcareEx.Auth
  alias Poison.SyntaxError, as: JsonError

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
      %{status_code: code, body: body |> parse_body()}
    end
  end

  @spec parse_body(binary()) :: map() | binary()
  defp parse_body(body) do
    try do
      body |> Poison.decode!()
    rescue
      JsonError -> body
    end
  end
end
