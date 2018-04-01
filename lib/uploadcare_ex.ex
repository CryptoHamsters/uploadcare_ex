defmodule UploadcareEx do
  alias UploadcareEx.Request
  alias UploadcareEx.API.Behaviour, as: ApiBehaviour
  alias UploadcareEx.API.Upload, as: UploadApi
  alias UploadcareEx.API.Files, as: FilesApi

  @behaviour ApiBehaviour

  @spec request(binary(), atom(), any(), map()) :: {:ok, Request.response()} | {:error, any()}
  defdelegate request(url, http_method, data \\ "", headers \\ %{}), to: Request

  @spec upload_url(binary()) :: {:ok, map()} | {:error, any()}
  defdelegate upload_url(url), to: UploadApi

  @spec upload_file(binary()) :: {:ok, binary()} | {:error, any()}
  defdelegate upload_file(file_path), to: UploadApi

  @spec file_info(binary()) :: {:ok, map()} | {:error, any()}
  def file_info(uuid) do
    uuid |> FilesApi.info()
  end

  @spec file_store(binary()) :: {:ok, map()} | {:error, any()}
  def file_store(uuid) do
    uuid |> FilesApi.store()
  end

  @spec file_delete(binary()) :: :ok | {:error, any()}
  def file_delete(uuid) do
    uuid |> FilesApi.delete()
  end
end
