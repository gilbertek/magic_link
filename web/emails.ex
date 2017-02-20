defmodule MagicLink.Emails do
  use Bamboo.Phoenix, view: MagicLink.EmailView
  alias MagicLink.{Router, Endpoint, User}

  @from "Recessiv <noreply@magician.com>"

  def send_login_link(token_value, user) do
    base_email()
    |> to(user)
    |> subject("Your login link.")
    |> assign(:link, token_url(token_value))
    |> render(:authentication_link)
  end

  defp base_email do
    new_email()
    |> from(@from)
    |> put_html_layout({MagicLink.LayoutView, "email.html"})
  end

  defp token_url(token) do
    Router.Helpers.signin_url(Endpoint, :show, token)
  end
end

defimpl Bamboo.Formatter, for: MagicLink.User do
  def format_email_address(user, _opts) do
    {user.email, user.email}
  end
end
