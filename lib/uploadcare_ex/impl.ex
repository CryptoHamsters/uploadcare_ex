defmodule UploadcareEx.Impl do
  alias UploadcareEx.Request
  alias UploadcareEx.API.Behaviour, as: ApiBehaviour
  alias UploadcareEx.API.Upload, as: UploadApi
  alias UploadcareEx.API.Files, as: FilesApi

  @behaviour ApiBehaviour

  @spec request(binary(), atom(), any(), map()) :: Request.response()
  defdelegate request(url, http_method, data \\ "", headers \\ %{}), to: UploadcareEx.Request

  @spec upload_url(binary()) :: {:ok, map()} | {:error, Request.response()}
  defdelegate upload_url(url), to: UploadApi

  @spec upload_file(binary()) :: {:ok, binary()} | {:error, Request.response()}
  defdelegate upload_file(file_path), to: UploadApi

  @spec file_info(binary()) :: {:ok, map()} | {:error, Request.response()}
  def file_info(uuid) do
    uuid |> FilesApi.info()
  end

  @spec file_store(binary()) :: {:ok, map()} | {:error, Request.response()}
  def file_store(uuid) do
    uuid |> FilesApi.store()
  end

  @spec file_delete(binary()) :: :ok | {:error, Request.response()}
  def file_delete(uuid) do
    uuid |> FilesApi.delete()
  end
end
