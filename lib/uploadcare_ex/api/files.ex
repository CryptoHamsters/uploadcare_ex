defmodule UploadcareEx.API.Files do
  alias UploadcareEx.API.Auth
  alias UploadcareEx.{Request, Config}

  @spec info(binary()) :: {:ok, map()} | {:error, Request.response()}
  def info(uuid) do
    info_url = api_url() <> "/files/#{uuid}/"

    case info_url |> Request.request(:get, "", auth_headers()) do
      %{body: body, status_code: 200} -> {:ok, body}
      other -> {:error, other}
    end
  end

  @spec auth_headers :: map()
  defp auth_headers do
    Auth.simple_auth_headers()
  end

  @spec api_url() :: binary()
  defp api_url do
    Config.api_url()
  end
end
