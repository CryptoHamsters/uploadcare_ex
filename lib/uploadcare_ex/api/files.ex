defmodule UploadcareEx.API.Files do
  alias UploadcareEx.API.Auth
  alias UploadcareEx.{Request, Config}

  @spec info(binary()) :: {:ok, map()} | {:error, Request.response()}
  def info(uuid) do
    info_url = base_url() <> "#{uuid}/"

    case info_url |> Request.request(:get, "", auth_headers()) do
      %{body: body, status_code: 200} -> {:ok, body}
      other -> {:error, other}
    end
  end

  @spec store(binary()) :: {:ok, map()} | {:error, Request.response()}
  def store(uuid) do
    store_url = base_url() <> "#{uuid}/storage/"

    case store_url |> Request.request(:put, "", auth_headers()) do
      %{body: body, status_code: 200} -> {:ok, body}
      other -> {:error, other}
    end
  end

  @spec delete(binary()) :: :ok | {:error, Request.response()}
  def delete(uuid) do
    delete_url = base_url() <> "#{uuid}/storage/"

    case delete_url |> Request.request(:delete, "", auth_headers()) do
      %{status_code: 302} -> :ok
      other -> {:error, other}
    end
  end

  @spec base_url() :: binary()
  defp base_url do
    Config.api_url() <> "/files/"
  end

  @spec auth_headers :: map()
  defp auth_headers do
    Auth.simple_auth_headers()
  end
end
