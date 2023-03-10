defmodule FirmApp.CourtFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FirmApp.Court` context.
  """

  @doc """
  Generate a case.
  """
  def case_fixture(attrs \\ %{}) do
    {:ok, case} =
      attrs
      |> Enum.into(%{
        court: "some court",
        court_no: "some court_no",
        judge: "some judge",
        lawyer: "some lawyer",
        next_date: ~D[2022-10-09],
        petitioner: "some petitioner",
        reg_num: "some reg_num",
        respondent: "some respondent",
        status: "some status",
        titel: "some titel",
        type: "some type",
        usclient_id: 42
      })
      |> FirmApp.Court.create_case()

    case
  end
end
