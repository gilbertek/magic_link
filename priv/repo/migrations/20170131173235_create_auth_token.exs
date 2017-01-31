defmodule MagicLink.Repo.Migrations.CreateAuthToken do
  use Ecto.Migration

  def change do
    create table(:auth_tokens) do
      add :value, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:auth_tokens, [:user_id])
    create unique_index(:auth_tokens, [:value])
  end
end
