defmodule UploadcareEx do
  use Application

  alias UploadcareEx.Server

  def start(_type, _args) do
    children = [Server]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def upload_url(url) do
    GenServer.call(Server, {:upload_url, url})
  end
end
