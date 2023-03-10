defmodule FirmApp.Files do
  @moduledoc """
  The Files context.
  """

  import Ecto.Query, warn: false
  alias FirmApp.Repo

  alias FirmApp.Files.Document

  def subscribe do
    Phoenix.PubSub.subscribe(FirmApp.PubSub, "document")
  end

  @doc """
  Returns the list of upload.

  ## Examples

      iex> list_upload()
      [%Uploads{}, ...]

  """
  def list_upload do
    Repo.all(Document)
  end

  @doc """
  Gets a single uploads.

  Raises `Ecto.NoResultsError` if the Uploads does not exist.

  ## Examples

      iex> get_uploads!(123)
      %Uploads{}

      iex> get_uploads!(456)
      ** (Ecto.NoResultsError)

  """
  def get_uploads!(id), do: Repo.get!(Document, id)

  @doc """
  Creates a uploads.

  ## Examples

      iex> create_uploads(%{field: value})
      {:ok, %Uploads{}}

      iex> create_uploads(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_uploads(attrs \\ %{}) do
    %Document{}
    |> Document.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a uploads.

  ## Examples

      iex> update_uploads(uploads, %{field: new_value})
      {:ok, %Uploads{}}

      iex> update_uploads(uploads, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_uploads(%Document{} = document, attrs) do
    document
    |> Document.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a uploads.

  ## Examples

      iex> delete_uploads(uploads)
      {:ok, %Uploads{}}

      iex> delete_uploads(uploads)
      {:error, %Ecto.Changeset{}}

  """
  def delete_uploads(%Document{} = document) do
    Repo.delete(document)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking uploads changes.

  ## Examples

      iex> change_uploads(uploads)
      %Ecto.Changeset{data: %Uploads{}}

  """
  def change_uploads(%Document{} = document, attrs \\ %{}) do
    Document.changeset(document, attrs)
  end

  def broadcast({:ok, document}, event) do
    Phoenix.PubSub.broadcast(
      FirmApp.PubSub,
      "document",
      {event, document}
    )
    {:ok, document}
  end

  def broadcast({:error, _reason} = error, _event), do: error
end
