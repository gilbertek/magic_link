defmodule MagicLink.Mailer do
  @moduledoc """
    Base Mailer.
    Uses Bamboo mailer package
  """
  use Bamboo.Mailer, otp_app: :magic_link

  defimpl Bamboo.Formatter, for: User do
    def format_email_address(user, _opts) do
      {user.email}
    end
  end
end
