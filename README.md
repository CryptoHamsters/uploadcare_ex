# UploadcareEx [![CircleCI](https://circleci.com/gh/CryptoHamsters/uploadcare_ex.svg?style=svg)](https://circleci.com/gh/CryptoHamsters/uploadcare_ex)

Simple Elixir wrapper for Uploadcare API

## Installation

The package can be installed by adding `uploadcare_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:uploadcare_ex, "~> 0.1.1"}
  ]
end
```

## Configuration

### Required parameters:

```
config :uploadcare_ex,
  public_key: "public_key",
  private_key: "private_key",
  accept_header: "application/vnd.uploadcare-v0.5+json"
```

By default [Uploadcare.Simple auth-scheme](https://uploadcare.com/docs/api_reference/rest/requests_auth/) is used.

### Optional parameters

```
config :uploadcare_ex,
  ...
  store: "0",
  retry_period: 1_000,
  retry_expiry: 5_000
```

```retry_period``` and ```retry_expiry``` parameters are used for request retries in case of Uploadcare service server errors. Their default values are 1_000 and 5_000 respectively.

## Usage

Check out the [API reference](https://hexdocs.pm/uploadcare_ex/api-reference.html) for the latest documentation.

Example:

```elixir
      iex> UploadcareEx.file_info("a295f184-0328-4b30-be4d-f215d9cdbed7")
      {:ok,
       %{
         "datetime_removed" => nil,
         "datetime_stored" => nil,
         ...
        }
      }

      iex> UploadcareEx.upload_file("/my/path/image.png")
      {:ok, "a295f184-0328-4b30-be4d-f215d9cdbed7"}
```

Note that currently not all api method wrappers are implemented.

## Contributing

1. [Fork it!](https://github.com/CryptoHamsters/uploadcare_ex/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

UploadcareEx is released under the MIT License.
