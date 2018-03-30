defmodule UploadcareEx.Impl do
  defdelegate upload_url(url), to: UploadcareEx.Upload
end
