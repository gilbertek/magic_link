defmodule MagicLink.TokenAuthenticationTest do
  use MagicLink.TestWithEcto, async: false

  alias Phoenix.Token
  alias MagicLink.AuthToken
  alias MagicLink.User

 test "provide token to user" do
   insert(:user, email: "machoman@gmail.com")

   user = Repo.one(User)
 IEX.pry
 end
end
