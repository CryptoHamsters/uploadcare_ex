defmodule UploadcareEx.API.Upload.File do
  alias UploadcareEx.{Request, Config}
  import UploadcareEx.API.Urls

  @spec upload(binary()) :: {:ok, binary()} | {:error, Request.response()}
  def upload(file_path) do
    file_path |> upload_file
  end

  @spec upload_file(binary()) :: {:ok, binary()} | {:error, Request.response()}
  defp upload_file(file_path) do
    form = file_path |> upload_form()

    case base_upload_url() |> Request.request(:post, form) do
      %{body: %{"file" => file_uuid}, status_code: 200} -> {:ok, file_uuid}
      other -> {:error, other}
    end
  end

  @spec upload_form(binary()) :: tuple()
  defp upload_form(file_path) do
    {
      :multipart,
      [
        {"UPLOADCARE_PUB_KEY", Config.public_key()},
        {"UPLOADCARE_STORE", Config.store()},
        {:file, file_path}
      ]
    }
  end

  @spec base_upload_url() :: binary()
  def base_upload_url do
    upload_url() <> "/base/"
  end
end
