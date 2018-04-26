use Mix.Config

config :uploadcare_ex,
  public_key: "3f5c4ce6fcdaf7aeace8",
  private_key: "06aa7fca4eee96801cc4",
  retry_period: 1_000,
  retry_expiry: 5_000,
  upload_url_retry_period: 300,
  upload_url_retry_expiry: 1_500
