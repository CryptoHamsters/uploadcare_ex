defmodule UploadcareEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :uploadcare_ex,
      version: "0.1.4",
      elixir: "~> 1.6",
      description: "Elixir wrapper for Uploadcare API",
      package: [
        maintainers: ["Ayrat Badykov", "Vitali Kharevich"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/CryptoHamsters/uploadcare_ex"}
      ],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [ignore_warnings: "dialyzer.ignore-warnings"]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :retry]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 2.0 or ~> 3.1"},
      {:retry, "~> 0.13"},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:exvcr, "~> 0.10", only: :test},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false}
    ]
  end
end
