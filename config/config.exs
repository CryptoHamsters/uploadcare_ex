use Mix.Config

config :uploadcare_ex,
  upload_url: "https://upload.uploadcare.com",
  api_url: "https://api.uploadcare.com"

import_config "#{Mix.env()}.exs"
