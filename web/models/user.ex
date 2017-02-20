defmodule MagicLink.User do
  use MagicLink.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string

    timestamps()
    has_many :auth_tokens, MagicLink.AuthToken
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
    |> validate_required([:email])
  end
end
