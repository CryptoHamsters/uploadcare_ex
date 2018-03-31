defmodule UploadcareEx do
  use Application

  alias UploadcareEx.Server
  alias UploadcareEx.API.Behaviour, as: ApiBehaviour
  alias UploadcareEx.Request

  @behaviour ApiBehaviour

  def start(_type, _args) do
    children = [Server]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  @spec request(binary(), atom(), any(), map()) :: Request.response()
  def request(url, http_method, data \\ "", headers \\ %{}) do
    GenServer.call(Server, {:request, url, http_method, data, headers})
  end

  @spec upload_url(binary()) :: {:ok, map()} | {:error, Request.response()}
  def upload_url(url) do
    GenServer.call(Server, {:upload_url, url})
  end

  @spec upload_file(binary()) :: {:ok, binary()} | {:error, Request.response()}
  def upload_file(file_path) do
    GenServer.call(Server, {:upload_file, file_path})
  end

  @spec file_info(binary()) :: {:ok, map()} | {:error, Request.response()}
  def file_info(uuid) do
    GenServer.call(Server, {:file_info, uuid})
  end

  @spec file_store(binary()) :: {:ok, map()} | {:error, Request.response()}
  def file_store(uuid) do
    GenServer.call(Server, {:file_store, uuid})
  end

  @spec file_delete(binary()) :: :ok | {:error, Request.response()}
  def file_delete(uuid) do
    GenServer.call(Server, {:file_delete, uuid})
  end
end
