defmodule FirmAppWeb.SampleLive.Index do
  use FirmAppWeb, :live_view

  alias FirmApp.Court
  alias FirmApp.Accounts

  def mount(_, %{"current_user" => user_id} = _session , socket) do
    current_user = Accounts.get_user!(user_id)
    {:ok,
    socket
    |> assign(cases: Court.list_case, current_user: current_user)
    |> allow_upload(:photo, accept: ~W(.png .jpg .docx .pdf), max_entries: 10, max_file_size: 10_000_000)
    }
    IO.inspect(socket)
  end


end
