defmodule FirmApp.MeetingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FirmApp.Meeting` context.
  """

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    {:ok, appointment} =
      attrs
      |> Enum.into(%{
        client_id: 42,
        date: ~D[2022-10-16],
        place: "some place",
        reason: "some reason",
        status: "some status",
        time: "some time",
        with: 42
      })
      |> FirmApp.Meeting.create_appointment()

    appointment
  end
end
