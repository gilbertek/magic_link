defmodule MagicLink.TokenAuthentication do
  @moduledoc """
  Provide sign in functionality for magic link feature
  """

  import Ecto.Query, only: [where: 3]

  alias Phoenix.Token
  alias MagicLink.{AuthToken, Endpoint, Repo, User, Emails, Mailer}

  # token is valid for 30 minutes / 1800 seconds
  @token_max_age 1_800

  @doc"""
  Creates and sends a new magic login token to the user or email.
  """
  def provide_token(nil), do: {:error, :not_found}

  def provide_token(email) when is_binary(email) do
    email = String.downcase(email)

    user_struct =
      case Repo.get_by(User, email: email) do
        nil -> %User{email: email}
        user -> user
      end

    IO.inspect user_struct

    changeset = User.changeset(user_struct)

    case Repo.insert_or_update(changeset) do
      {:ok, user} ->
        IO.inspect user
        send_token(user)
      {:error, changeset} ->
        IO.inspect changeset
        changeset
    end

    # User
    # |> Repo.get_by(email: email)
    # |> send_token()
  end

  def provide_token(user = %User{}) do
    send_token(user)
  end

  @doc"""
  Checks the given token
  """
  def verify_token_value(value) do
    AuthToken
    |> where([t], t.value == ^value)
    |> where([t], t.inserted_at > datetime_add(^Ecto.DateTime.utc, ^(@token_max_age * -1), "second"))
    |> Repo.one()
    |> verify_token()
  end

  # Unexpired token could not be found.
  defp verify_token(nil), do: {:error, :invalid}

  defp verify_token(token) do
    token =
      token
      |> Repo.preload(:user)
      |> Repo.delete!

    user_id = token.user.id

    # verify the token matching the user id
    case Token.verify(Endpoint, "user", token.value, max_age: @token_max_age) do
      {:ok, ^user_id} ->
        {:ok, token.user}

      # reason can be :invalid or :expired
      {:error, reason} ->
        {:error, reason}
    end
  end

  # User could not be found by email.
  defp send_token(nil), do: {:error, :not_found}

  # Creates a token and sends it to the user.
  defp send_token(user) do
    user
    |> create_token()
    |> Emails.send_login_link(user)
    |> Mailer.deliver_now()

    {:ok, user}
  end

  # Creates a new token for the given user and returns the token value.
  defp create_token(user) do
    changeset = AuthToken.changeset(%AuthToken{}, user)
    auth_token = Repo.insert!(changeset)
    auth_token.value
  end
end
