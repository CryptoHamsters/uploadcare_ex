defmodule UploadcareEx.API.Upload.FileTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias UploadcareEx.API.Upload.File

  setup_all do
    HTTPoison.start()
  end

  describe "upload/1" do
    test "uploads image" do
      use_cassette "file_upload_success" do
        path = System.cwd() <> "/test/test_files/test.png"

        {:ok, _uuuid} = path |> File.upload()
      end
    end

    test "fails to upload image" do
      use_cassette "file_upload_failure" do
        path = System.cwd() <> "/wrong.png"

        {
          :error,
          {:error, %HTTPoison.Error{id: nil, reason: "enoent"}}
        } = path |> File.upload()
      end
    end
  end
end
