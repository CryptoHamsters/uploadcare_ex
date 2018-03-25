defmodule UplodcareEx.ConfigTest do
  use ExUnit.Case, async: true
  alias UploadcareEx.Config

  describe "public_key/1" do
    test "fails with error if config is not provided" do
      assert_raise ArgumentError, fn ->
        Config.public_key()
      end
    end
  end
end
