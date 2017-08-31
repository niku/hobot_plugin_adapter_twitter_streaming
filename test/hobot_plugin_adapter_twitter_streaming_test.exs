defmodule Hobot.Plugin.Adapter.TwitterStreamingTest do
  use ExUnit.Case
  doctest Hobot.Plugin.Adapter.TwitterStreaming

  test "greets the world" do
    assert Hobot.Plugin.Adapter.TwitterStreaming.hello() == :world
  end
end
