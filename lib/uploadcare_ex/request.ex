defmodule UploadcareEx.Request do
  use Retry

  import UploadcareEx.Config

  alias Poison.SyntaxError, as: JsonError

  @type response :: %{status_code: number(), body: map() | binary()}

  @spec request(binary(), atom(), any(), map()) :: {:ok, response()} | {:error, any()}
  def request(url, http_method, data \\ "", headers \\ %{}) do
    request_with_retries(url, http_method, data, headers)
  end

  @spec request_with_retries(binary(), atom(), any(), map()) ::
          {:ok, response()} | {:error, any()}
  defp request_with_retries(url, http_method, data, headers) do
    retry with: exp_backoff() |> randomize() |> cap(retry_period()) |> expiry(retry_expiry()) do
      case send_request(url, http_method, data, headers) do
        response = %{status_code: _} -> response |> check_status()
        other -> {:error, other}
      end
    end
  end

  @spec send_request(binary(), atom(), any(), map()) :: response() | {:error, any()}
  defp send_request(url, http_method, data, headers) do
    case HTTPoison.request(http_method, url, data, headers) do
      {
        :ok,
        %HTTPoison.Response{
          status_code: code,
          body: body
        }
      } ->
        %{status_code: code, body: body |> parse_body()}

      {:error, description} ->
        description

      other ->
        other
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

  @spec check_status(response()) :: {:ok, response()} | {:error, response()}
  defp check_status(%{status_code: status_code} = response) do
    first_digit =
      status_code
      |> Integer.digits()
      |> List.first()

    if first_digit == 5, do: {:error, response}, else: {:ok, response}
  end
end
