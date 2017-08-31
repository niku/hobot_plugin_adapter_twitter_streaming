defmodule Hobot.Plugin.Adapter.TwitterStreaming.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hobot_plugin_adapter_twitter_streaming,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :logger,
        :extwitter
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:extwitter, "~> 0.8"}
    ]
  end

  defp description do
    "TODO: Add description"
  end

  defp package do
    [maintainers: ["niku"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/niku/hobot_plugin_adapter_twitter_streaming"}]
  end
end
