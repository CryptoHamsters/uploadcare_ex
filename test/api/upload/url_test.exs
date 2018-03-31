defmodule UploadcareEx.API.Upload.UrlTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias UploadcareEx.API.Upload.Url

  setup_all do
    HTTPoison.start()
  end

  describe "upload/1" do
    test "uploads url" do
      use_cassette "url_upload_success" do
        test_url = "https://i.imgur.com/qMV7tJ4.png"

        {:ok,
         %{
           "done" => 327_948,
           "file_id" => "172cc9ec-f418-410c-9c95-b813a27caf88",
           "filename" => "qMV7tJ4.png",
           "image_info" => %{
             "datetime_original" => nil,
             "dpi" => nil,
             "format" => "PNG",
             "geo_location" => nil,
             "height" => 480,
             "orientation" => nil,
             "width" => 460
           },
           "is_image" => true,
           "is_ready" => false,
           "is_stored" => false,
           "mime_type" => "image/png",
           "original_filename" => "qMV7tJ4.png",
           "size" => 327_948,
           "status" => "success",
           "total" => 327_948,
           "uuid" => "172cc9ec-f418-410c-9c95-b813a27caf88"
         }} = test_url |> Url.upload()
      end
    end

    test "fails to upload url" do
      use_cassette "url_upload_failure" do
        test_url = "https://google.com"

        {:error, %{body: %{"status" => "unknown"}, status_code: 200}} =
          test_url |> Url.upload()
      end
    end
  end
end
