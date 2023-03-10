defmodule FirmApp.CourtTest do
  use FirmApp.DataCase

  alias FirmApp.Court

  describe "case" do
    alias FirmApp.Court.Case

    import FirmApp.CourtFixtures

    @invalid_attrs %{court: nil, court_no: nil, judge: nil, lawyer: nil, next_date: nil, petitioner: nil, reg_num: nil, respondent: nil, status: nil, titel: nil, type: nil, usclient_id: nil}

    test "list_case/0 returns all case" do
      case = case_fixture()
      assert Court.list_case() == [case]
    end

    test "get_case!/1 returns the case with given id" do
      case = case_fixture()
      assert Court.get_case!(case.id) == case
    end

    test "create_case/1 with valid data creates a case" do
      valid_attrs = %{court: "some court", court_no: "some court_no", judge: "some judge", lawyer: "some lawyer", next_date: ~D[2022-10-09], petitioner: "some petitioner", reg_num: "some reg_num", respondent: "some respondent", status: "some status", titel: "some titel", type: "some type", usclient_id: 42}

      assert {:ok, %Case{} = case} = Court.create_case(valid_attrs)
      assert case.court == "some court"
      assert case.court_no == "some court_no"
      assert case.judge == "some judge"
      assert case.lawyer == "some lawyer"
      assert case.next_date == ~D[2022-10-09]
      assert case.petitioner == "some petitioner"
      assert case.reg_num == "some reg_num"
      assert case.respondent == "some respondent"
      assert case.status == "some status"
      assert case.titel == "some titel"
      assert case.type == "some type"
      assert case.usclient_id == 42
    end

    test "create_case/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Court.create_case(@invalid_attrs)
    end

    test "update_case/2 with valid data updates the case" do
      case = case_fixture()
      update_attrs = %{court: "some updated court", court_no: "some updated court_no", judge: "some updated judge", lawyer: "some updated lawyer", next_date: ~D[2022-10-10], petitioner: "some updated petitioner", reg_num: "some updated reg_num", respondent: "some updated respondent", status: "some updated status", titel: "some updated titel", type: "some updated type", usclient_id: 43}

      assert {:ok, %Case{} = case} = Court.update_case(case, update_attrs)
      assert case.court == "some updated court"
      assert case.court_no == "some updated court_no"
      assert case.judge == "some updated judge"
      assert case.lawyer == "some updated lawyer"
      assert case.next_date == ~D[2022-10-10]
      assert case.petitioner == "some updated petitioner"
      assert case.reg_num == "some updated reg_num"
      assert case.respondent == "some updated respondent"
      assert case.status == "some updated status"
      assert case.titel == "some updated titel"
      assert case.type == "some updated type"
      assert case.usclient_id == 43
    end

    test "update_case/2 with invalid data returns error changeset" do
      case = case_fixture()
      assert {:error, %Ecto.Changeset{}} = Court.update_case(case, @invalid_attrs)
      assert case == Court.get_case!(case.id)
    end

    test "delete_case/1 deletes the case" do
      case = case_fixture()
      assert {:ok, %Case{}} = Court.delete_case(case)
      assert_raise Ecto.NoResultsError, fn -> Court.get_case!(case.id) end
    end

    test "change_case/1 returns a case changeset" do
      case = case_fixture()
      assert %Ecto.Changeset{} = Court.change_case(case)
    end
  end
end
