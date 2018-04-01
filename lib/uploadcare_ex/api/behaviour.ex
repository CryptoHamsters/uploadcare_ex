defmodule UploadcareEx.API.Behaviour do
  alias UploadcareEx.Request

  @callback request(binary(), atom(), any(), map()) :: {:ok, Request.response()} | {:error, any()}
  @callback upload_url(binary()) :: {:ok, map()} | {:error, any()}
  @callback upload_file(binary()) :: {:ok, binary()} | {:error, any()}
  @callback file_info(binary()) :: {:ok, map()} | {:error, any()}
  @callback file_store(binary()) :: {:ok, map()} | {:error, any()}
  @callback file_delete(binary()) :: :ok | {:error, any()}
end
