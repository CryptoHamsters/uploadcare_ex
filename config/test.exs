use Mix.Config

config :uploadcare_ex,
  public_key: "3f5c4ce6fcdaf7aeace8",
  private_key: "06aa7fca4eee96801cc4",
  accept_header: "application/vnd.uploadcare-v0.5+json",
  store: "0",
  retry_period: 1_000,
  retry_expiry: 5_000
