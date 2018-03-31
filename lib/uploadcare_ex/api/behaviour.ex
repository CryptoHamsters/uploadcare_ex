defmodule UploadcareEx.API.Behaviour do
  alias UploadcareEx.Request

  @callback request(binary(), atom(), any(), map()) :: Request.response()
  @callback upload_url(binary()) :: {:ok, map()} | {:error, Request.response()}
  @callback upload_file(binary()) :: {:ok, binary()} | {:error, Request.response()}
end