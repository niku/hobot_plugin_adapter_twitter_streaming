defmodule Hobot.Plugin.Adapter.TwitterStreaming do
  @moduledoc """
  Documentation for Hobot.Plugin.Adapter.TwitterStreaming.
  """

  use GenServer

  def init({context, %{consumer_key: _, consumer_secret: _, access_token: _, access_token_secret: _} = credential, %{} = stream_option}) do
    # Configure to use ExTwitter.update/1 in handle_cast/2
    ExTwitter.configure(:process, Map.to_list(credential))
    {:ok, stream} = do_start_stream(credential, stream_option)
    {:ok, {context, credential, stream_option, stream}}
  end

  def handle_cast({:reply, _ref, data}, state) do
    ExTwitter.update(data)
    {:noreply, state}
  end

  def handle_info(tweet, {context, _, _, _} = state) do
    apply(context.publish, ["on_message", make_ref(), tweet])
    {:noreply, state}
  end

  defp do_start_stream(%{consumer_key: _, consumer_secret: _, access_token: _, access_token_secret: _} = credential, %{} = stream_option) do
    me = self()
    Task.start_link(fn ->
      ExTwitter.configure(:process, Map.to_list(credential))
      ExTwitter.stream_filter(Map.to_list(stream_option), :infinity)
      |> Stream.each(fn tweet -> send(me, tweet) end)
      |> Enum.to_list
    end)
  end
end
