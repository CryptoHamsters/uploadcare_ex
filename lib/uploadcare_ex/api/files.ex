defmodule UploadcareEx.API.Files do
  import UploadcareEx.API.Urls

  alias UploadcareEx.API.Auth
  alias UploadcareEx.Request

  @spec info(binary()) :: {:ok, map()} | {:error, Request.response()}
  def info(uuid) do
    info_url = base_url() <> "#{uuid}/"

    case info_url |> Request.request(:get, "", auth_headers()) do
      {:ok, %{body: body, status_code: 200}} -> {:ok, body}
      {:ok, response} -> {:error, response}
      other -> other
    end
  end

  @spec store(binary()) :: {:ok, map()} | {:error, Request.response()}
  def store(uuid) do
    store_url = base_url() <> "#{uuid}/storage/"

    case store_url |> Request.request(:put, "", auth_headers()) do
      {:ok, %{body: body, status_code: 200}} -> {:ok, body}
      {:ok, response} -> {:error, response}
      other -> other
    end
  end

  @spec delete(binary()) :: :ok | {:error, Request.response()}
  def delete(uuid) do
    delete_url = base_url() <> "#{uuid}/storage/"

    case delete_url |> Request.request(:delete, "", auth_headers()) do
      {:ok, %{status_code: 302}} -> :ok
      {:ok, response} -> {:error, response}
      other -> {:error, other}
    end
  end

  @spec base_url() :: binary()
  defp base_url do
    api_url() <> "/files/"
  end

  @spec auth_headers :: map()
  defp auth_headers do
    Auth.simple_auth_headers()
  end
end
