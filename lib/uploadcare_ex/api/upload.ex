defmodule UploadcareEx.API.Upload do
  alias UploadcareEx.API.Upload.{Url, File}
  alias UploadcareEx.Request

  @spec upload_url(binary()) :: {:ok, map()} | {:error, Request.response()}
  def upload_url(url) do
    url |> Url.upload()
  end

  @spec upload_file(binary()) :: {:ok, binary()} | {:error, Request.response()}
  def upload_file(file_path) do
    file_path |> File.upload()
  end
end
