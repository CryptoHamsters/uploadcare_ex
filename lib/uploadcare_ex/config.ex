defmodule UploadcareEx.Config do
  @moduledoc false

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
    get_env_var!(:accept_header)
  end

  @spec store() :: binary()
  def store do
    get_env_var!(:store)
  end

  @spec retry_period() :: number()
  def retry_period do
    get_env_var!(:retry_period)
  end

  @spec retry_expiry() :: number()
  def retry_expiry do
    get_env_var!(:retry_expiry)
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
