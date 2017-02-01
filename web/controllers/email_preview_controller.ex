defmodule MagicLink.EmailPreviewController do
  use MagicLink.Web, :controller

  alias MagicLink.EmailPreview

  def show(conn, %{"id" => id}) do
    email_preview = Repo.get!(EmailPreview, id)
    render(conn, "show.html", email_preview: email_preview)
  end
end
