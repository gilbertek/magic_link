defmodule MagicLink.Emails do
  use Bamboo.Phoenix, view: MagicLink.EmailView

  require IEx

  # import Bamboo.MandrillHelper
  # import Bamboo.Email
  # import Bamboo.Phoenix

  def send_login_link(token_value, user) do
    IEx.pry
  end

  defp base_email do
    new_email()
    |> from("robot@magician.com")
  end

end
