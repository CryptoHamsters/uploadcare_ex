defmodule UploadcareEx.Impl do
  defdelegate upload_url(url), to: UploadcareEx.API.Upload
end
