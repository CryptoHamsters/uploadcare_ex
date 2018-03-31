defmodule UploadcareEx.API.FilesTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias UploadcareEx.API.Files

  setup_all do
    HTTPoison.start()
  end

  describe "info/1" do
    test "returns file info" do
      use_cassette "files_info_success" do
        {:ok, %{}} = "172cc9ec-f418-410c-9c95-b813a27caf88" |> Files.info()
      end
    end

    test "failes to return file info" do
      use_cassette "files_info_failure" do
        {
          :error,
          %{body: %{"detail" => "Not found."}, status_code: 404}
        } = "wrong" |> Files.info()
      end
    end
  end
end
