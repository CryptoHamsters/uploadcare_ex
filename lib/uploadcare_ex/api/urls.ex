defmodule UploadcareEx.API.Urls do
  @moduledoc false

  @upload_url "https://upload.uploadcare.com"
  @api_url "https://api.uploadcare.com"

  @spec upload_url() :: binary()
  def upload_url do
    @upload_url
  end

  @spec api_url() :: binary()
  def api_url do
    @api_url
  end
end
