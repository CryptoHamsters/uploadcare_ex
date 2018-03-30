defmodule UploadcareEx.Auth do
  alias UploadcareEx.Config

  @spec simple_auth_headers() :: map()
  def simple_auth_headers do
    %{
      "Accept" => accept_header(),
      "Authorization" => "Uploadcare.Simple #{public_key()}:#{private_key()}"
    }
  end

  @spec accept_header() :: binary()
  defp accept_header do
    Config.accept_header()
  end

  @spec public_key() :: binary()
  defp public_key do
    Config.public_key()
  end

  @spec private_key() :: binary()
  defp private_key do
    Config.private_key()
  end
end
