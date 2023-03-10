defmodule FirmApp.MeetingTest do
  use FirmApp.DataCase

  alias FirmApp.Meeting

  describe "appointment" do
    alias FirmApp.Meeting.Appointment

    import FirmApp.MeetingFixtures

    @invalid_attrs %{client_id: nil, date: nil, place: nil, reason: nil, status: nil, time: nil, with: nil}

    test "list_appointment/0 returns all appointment" do
      appointment = appointment_fixture()
      assert Meeting.list_appointment() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert Meeting.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      valid_attrs = %{client_id: 42, date: ~D[2022-10-16], place: "some place", reason: "some reason", status: "some status", time: "some time", with: 42}

      assert {:ok, %Appointment{} = appointment} = Meeting.create_appointment(valid_attrs)
      assert appointment.client_id == 42
      assert appointment.date == ~D[2022-10-16]
      assert appointment.place == "some place"
      assert appointment.reason == "some reason"
      assert appointment.status == "some status"
      assert appointment.time == "some time"
      assert appointment.with == 42
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meeting.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()
      update_attrs = %{client_id: 43, date: ~D[2022-10-17], place: "some updated place", reason: "some updated reason", status: "some updated status", time: "some updated time", with: 43}

      assert {:ok, %Appointment{} = appointment} = Meeting.update_appointment(appointment, update_attrs)
      assert appointment.client_id == 43
      assert appointment.date == ~D[2022-10-17]
      assert appointment.place == "some updated place"
      assert appointment.reason == "some updated reason"
      assert appointment.status == "some updated status"
      assert appointment.time == "some updated time"
      assert appointment.with == 43
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()
      assert {:error, %Ecto.Changeset{}} = Meeting.update_appointment(appointment, @invalid_attrs)
      assert appointment == Meeting.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = Meeting.delete_appointment(appointment)
      assert_raise Ecto.NoResultsError, fn -> Meeting.get_appointment!(appointment.id) end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = Meeting.change_appointment(appointment)
    end
  end
end
