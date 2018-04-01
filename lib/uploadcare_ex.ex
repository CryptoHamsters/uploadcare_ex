defmodule UploadcareEx do
  alias UploadcareEx.Request
  alias UploadcareEx.API.Behaviour, as: ApiBehaviour
  alias UploadcareEx.API.Upload, as: UploadApi
  alias UploadcareEx.API.Files, as: FilesApi

  @behaviour ApiBehaviour
  @type response :: %{status_code: number(), body: map() | binary()}

  @moduledoc """
  Elixir wrapper for Uploadcare API.
  """

  @doc """
  Basic request method with retries.

  Retries are configured with `retry_period` and `retry_expiry` configuration params
  in your config.exs. Their default values are 1_000 and 5_000 respectively. All requests that get
  responses with 5xx status codes are retried. Also all HTTPoison (which is used as a default http client)
  errors are retried.

  Examples:

      iex> UploadcareEx.request("https://api.uploadcare.com/files/2e6b7f23-9143-4b71-94e7-338bbf278c01/", :get)
      {:ok,
       %{
         body: %{"detail" => "Authentication credentials were not provided."},
         status_code: 401
       }}

      iex> UploadcareEx.request("https://upload.uploadcare.com/from_url/status/?token=b8a3eb85-c01d-4809-9ba7-7590e4e7300f", :get)
      {:ok,
       %{...}
      }
  """
  @spec request(binary(), atom(), any(), map()) :: {:ok, response()} | {:error, any()}
  defdelegate request(url, http_method, data \\ "", headers \\ %{}), to: Request

  @doc """
  Uploads files from URLs. Returns created file status.

  Examples:

      iex> UploadcareEx.upload_url("https://avatars0.githubusercontent.com/u/6567687?s=460&v=4")
      {:ok,
       %{
         "done" => 20344,
         "file_id" => "b82a3688-27fb-431d-aac8-1b50553b8779",
         "filename" => "6567687",
         ...
        }
      }

      iex> UploadcareEx.upload_url("https://google.com")
      "https://upload.uploadcare.com/from_url/status/?token=fcad48ae-6be6-4d0b-8543-8cc7703d2b71"
      {:error,
       %{
         body: %{
           "error" => "Uploading of these files types is not allowed on your current plan.",
           "status" => "error"
         },
         status_code: 200
       }
      }
  """
  @spec upload_url(binary()) :: {:ok, map()} | {:error, any()}
  defdelegate upload_url(url), to: UploadApi

  @doc """
  Uploads a file from provided filesystem path. Returns created file uuid.

  Examples:

      iex> UploadcareEx.upload_file("/my/path/image.png")
      {:ok, "a295f184-0328-4b30-be4d-f215d9cdbed7"}

      iex> UploadcareEx.upload_file("/invalid")
      {:error, %HTTPoison.Error{id: nil, reason: :enoent}}
  """
  @spec upload_file(binary()) :: {:ok, binary()} | {:error, any()}
  defdelegate upload_file(file_path), to: UploadApi

  @doc """
  Acquires file-specific info by its uuid.

  Examples:

      iex> UploadcareEx.file_info("a295f184-0328-4b30-be4d-f215d9cdbed7")
      {:ok,
       %{
         "datetime_removed" => nil,
         "datetime_stored" => nil,
         ...
        }
      }

      iex> UploadcareEx.file_info("wrong")
      {:error, %{body: %{"detail" => "Not found."}, status_code: 404}}
  """
  @spec file_info(binary()) :: {:ok, map()} | {:error, any()}
  def file_info(uuid) do
    uuid |> FilesApi.info()
  end

  @doc """
  Stores a file by its uuid.

  Examples:

      iex> UploadcareEx.file_store("a295f184-0328-4b30-be4d-f215d9cdbed7")
      {:ok,
       %{
         "datetime_removed" => nil,
         "datetime_stored" => "2018-04-01T16:17:26.699680Z",
         ...
        }
       }

      iex> UploadcareEx.file_store("wrong")
      {:error, %{body: %{"detail" => "Not found."}, status_code: 404}}
  """
  @spec file_store(binary()) :: {:ok, map()} | {:error, any()}
  def file_store(uuid) do
    uuid |> FilesApi.store()
  end

  @doc """
  Deletes a file by its uuid.

  Examples:

      iex> UploadcareEx.file_delete("a295f184-0328-4b30-be4d-f215d9cdbed7")
      :ok

      iex> UploadcareEx.file_delete("wrong")
      {:error, %{body: %{"detail" => "Not found."}, status_code: 404}}
  """
  @spec file_delete(binary()) :: :ok | {:error, any()}
  def file_delete(uuid) do
    uuid |> FilesApi.delete()
  end
end
