defmodule UploadcareEx.Request do
  use Retry

  alias Poison.SyntaxError, as: JsonError

  @type response :: %{status_code: number(), body: map() | binary()}
  @dialyzer {:no_return, request_with_retries: 4}

  @spec request(binary(), atom(), any(), map()) :: response()
  def request(url, http_method, data \\ "", headers \\ %{}) do
    {_, response} = request_with_retries(url, http_method, data, headers)

    response
  end

  @spec request_with_retries(binary(), atom(), any(), map()) :: {atom(), response()}
  defp request_with_retries(url, http_method, data, headers) do
    retry with: exp_backoff() |> randomize() |> cap(1_000) |> expiry(5_000) do
      case send_request(url, http_method, data, headers) do
        %{status_code: 500} = result -> {:error, result}
        result -> {:ok, result}
      end
    end
  end

  @spec send_request(binary(), atom(), any(), map()) :: response()
  defp send_request(url, http_method, data, headers) do
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
