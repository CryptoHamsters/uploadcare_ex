defmodule UploadcareEx.API.Upload.File do
  alias UploadcareEx.{Request, Config}
  import UploadcareEx.API.Urls

  @moduledoc false

  @spec upload(binary()) :: {:ok, binary()} | {:error, any()}
  def upload(file_path) do
    file_path |> upload_file
  end

  @spec upload(binary(), binary(), binary()) :: {:ok, binary()} | {:error, any()}
  def upload(data, filename, content_type) do
    upload_file(data, filename, content_type)
  end

  @spec upload_file(binary()) :: {:ok, binary()} | {:error, any()}
  defp upload_file(file_path) do
    form = upload_form(file_path)

    case base_upload_url() |> Request.request(:post, form) do
      {:ok, %{body: %{"file" => file_uuid}, status_code: 200}} -> {:ok, file_uuid}
      {:ok, response} -> {:error, response}
      other -> other
    end
  end

  @spec upload_file(binary(), binary(), binary()) :: {:ok, binary()} | {:error, any()}
  defp upload_file(data, filename, content_type) do
    form = upload_form(data, filename, content_type)

    case base_upload_url() |> Request.request(:post, form) do
      {:ok, %{body: %{"file" => file_uuid}, status_code: 200}} -> {:ok, file_uuid}
      {:ok, response} -> {:error, response}
      other -> other
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

  defp upload_form(data, filename, content_type) do
    {
      :multipart,
      [
        {"UPLOADCARE_PUB_KEY", Config.public_key()},
        {"UPLOADCARE_STORE", Config.store()},
        {:file, IO.iodata_to_binary(data),
         {"form-data",
          [{"name", "\"file\""}, {"filename", filename}, {"mime_type", content_type}]},
         [{"Content-Type", content_type}]}
      ]
    }
  end

  @spec base_upload_url() :: binary()
  def base_upload_url do
    upload_url() <> "/base/"
  end
end
