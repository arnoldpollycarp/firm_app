defmodule FirmAppWeb.SampleLive.Show do
  use FirmAppWeb, :live_view

  def mount(_parmas, _session, socket) do
    IO.puts("Tracey")
    {:ok, socket}
  end

  def handle_params(%{"id" => "1"}, _url, socket) do
    {:noreply, socket}
  end
end
