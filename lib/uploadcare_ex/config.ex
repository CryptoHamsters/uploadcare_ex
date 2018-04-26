defmodule UploadcareEx.Config do
  @moduledoc """

  Configuration

  ### Required parameters:

  ```
  config :uploadcare_ex,
    public_key: "public_key",
    private_key: "private_key"
  ```

  By default [Uploadcare.Simple auth-scheme](https://uploadcare.com/docs/api_reference/rest/requests_auth/) is used.

  ### Optional parameters

  ```
  config :uploadcare_ex,
    ...
    accept_header: "application/vnd.uploadcare-v0.5+json",
    store: "0",
    retry_period: 1_000,
    retry_expiry: 5_000
  ```

  ```retry_period``` and ```retry_expiry``` parameters are used for request retries in case of Uploadcare service server errors. Their default values are 1_000 and 5_000 respectively.
  """

  @spec public_key() :: binary()
  def public_key do
    get_env_var!(:public_key)
  end

  @spec private_key() :: binary()
  def private_key do
    get_env_var!(:private_key)
  end

  @spec accept_header() :: binary()
  def accept_header do
    Application.get_env(:uploadcare_ex, :accept_header) || "application/vnd.uploadcare-v0.5+json"
  end

  @spec store() :: binary()
  def store do
    Application.get_env(:uploadcare_ex, :store) || "0"
  end

  @spec retry_period() :: number()
  def retry_period do
    Application.get_env(:uploadcare_ex, :retry_period) || 1_000
  end

  @spec retry_expiry() :: number()
  def retry_expiry do
    Application.get_env(:uploadcare_ex, :retry_expiry) || 5_000
  end

  @spec upload_url_retry_period() :: number()
  def upload_url_retry_period do
    Application.get_env(:uploadcare_ex, :upload_url_retry_period) || 300
  end

  @spec upload_url_retry_expiry() :: number()
  def upload_url_retry_expiry do
    Application.get_env(:uploadcare_ex, :upload_url_retry_expiry) || 20_000
  end

  @spec get_env_var!(atom()) :: binary() | number()
  defp get_env_var!(key) do
    case Application.get_env(:uploadcare_ex, key) do
      value when value != "" ->
        value

      els ->
        raise ArgumentError,
          message:
            "Please set config variable `config :uploadcare_ex, #{key}`, got: `#{inspect(els)}``"
    end
  end
end
