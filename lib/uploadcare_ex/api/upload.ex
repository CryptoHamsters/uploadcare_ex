defmodule UploadcareEx.API.Upload do
  alias UploadcareEx.API.Upload.{Url, File}
  alias UploadcareEx.Request

  @moduledoc false

  @spec upload_url(binary()) :: {:ok, map()} | {:error, Request.response()}
  def upload_url(url) do
    Url.upload(url)
  end

  @spec upload_file(binary()) :: {:ok, binary()} | {:error, Request.response()}
  def upload_file(file_path) do
    File.upload(file_path)
  end

  @spec upload_file(binary(), binary(), binary()) ::
          {:ok, binary()} | {:error, Request.response()}
  def upload_file(data, filename, content_type) do
    File.upload(data, filename, content_type)
  end
end
