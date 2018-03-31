defmodule UploadcareEx.Server do
  use GenServer
  alias UploadcareEx.Impl

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:request, url, http_method, data, headers}, _, state) do
    result = url |> Impl.request(http_method, data, headers)

    {:reply, result, state}
  end

  def handle_call({:upload_url, url}, _, state) do
    result = url |> Impl.upload_url()

    {:reply, result, state}
  end

  def handle_call({:upload_file, file_path}, _, state) do
    result = file_path |> Impl.upload_file()

    {:reply, result, state}
  end
end
