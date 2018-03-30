defmodule UploadcareEx.Upload do
  alias UploadcareEx.{Upload.Url, Request}

  @spec upload_url(binary()) :: {:ok, map()} | {:error, Request.response()}
  def upload_url(url) do
    url |> Url.upload()
  end
end
