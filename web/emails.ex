defmodule MagicLink.Emails do
  use Bamboo.Phoenix, view: MagicLink.EmailView

  # import Bamboo.MandrillHelper
  import Bamboo.Email
  import Bamboo.Phoenix

  def login_link(user) do
    IEX.pry
  end

  defp base_email do
    new_email()
    |> from("robot@magician.com")
  end

end
