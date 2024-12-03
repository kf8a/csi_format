defmodule CsiFormat.MixProject do
  use Mix.Project

  def project do
    [
      app: :csi_format,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "csi_format",
      source_url: "https://github.com/kf8a/csi_format",
      docs: &docs/0
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_csv, "~> 1.2"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      # The main page in the docs
      main: "CsiFormat",
      extras: ["README.md"]
    ]
  end
end
