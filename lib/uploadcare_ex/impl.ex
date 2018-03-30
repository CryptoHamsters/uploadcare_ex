defmodule UploadcareEx.Impl do
  alias UploadcareEx.Request
  alias UploadcareEx.API.Behaviour, as: ApiBehaviour

  @behaviour ApiBehaviour

  @spec request(binary(), atom(), any(), map()) :: Request.response()
  defdelegate upload_url(url), to: UploadcareEx.API.Upload

  @spec upload_url(binary()) :: {:ok, map()} | {:error, Request.response()}
  defdelegate request(url, http_method, data \\ "", headers \\ %{}), to: UploadcareEx.Request
end
