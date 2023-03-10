defmodule FirmApp.Meeting do
  @moduledoc """
  The Meeting context.
  """

  import Ecto.Query, warn: false
  alias FirmApp.Repo

  alias FirmApp.Meeting.Appointment

  def subscribe do
    Phoenix.PubSub.subscribe(FirmApp.PubSub, "appointment")
  end

  @doc """
  Returns the list of appointment.

  ## Examples

      iex> list_appointment()
      [%Appointment{}, ...]

  """
  def list_appointment do
    Repo.all(Appointment) |> Repo.preload(:user)
  end

  @doc """
  Gets a single appointment.

  Raises `Ecto.NoResultsError` if the Appointment does not exist.

  ## Examples

      iex> get_appointment!(123)
      %Appointment{}

      iex> get_appointment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_appointment!(id), do: Repo.get!(Appointment, id)

  @doc """
  Creates a appointment.

  ## Examples

      iex> create_appointment(%{field: value})
      {:ok, %Appointment{}}

      iex> create_appointment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_appointment(attrs \\ %{}) do
    %Appointment{}
    |> Appointment.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:appointment_created)
  end

  @doc """
  Updates a appointment.

  ## Examples

      iex> update_appointment(appointment, %{field: new_value})
      {:ok, %Appointment{}}

      iex> update_appointment(appointment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_appointment(%Appointment{} = appointment, attrs) do
    appointment
    |> Appointment.changeset(attrs)
    |> Repo.update()
    |> broadcast(:appointment_update)
  end

  @doc """
  Deletes a appointment.

  ## Examples

      iex> delete_appointment(appointment)
      {:ok, %Appointment{}}

      iex> delete_appointment(appointment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_appointment(%Appointment{} = appointment) do
    Repo.delete(appointment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking appointment changes.

  ## Examples

      iex> change_appointment(appointment)
      %Ecto.Changeset{data: %Appointment{}}

  """
  def change_appointment(%Appointment{} = appointment, attrs \\ %{}) do
    Appointment.changeset(appointment, attrs)
  end

  def broadcast({:ok, appointment}, event) do
    Phoenix.PubSub.broadcast(
      FirmApp.PubSub,
      "appointment",
      {event, appointment}
    )
    {:ok, appointment}
  end

  def broadcast({:error, _reason} = error, _event), do: error
end
