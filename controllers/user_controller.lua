local Model = require("lapis.db.model").Model
local Users = Model:extend("users")
local db = require("lapis.db")

return {
  login = function(self)
    self.load = "/login_page"
    return { render = "pages.login_signup.login_signup_page" }
  end,
  login_page = function()
    return { render = "pages.login_signup.login.login_page" }
  end,
  signup = function(self)
    self.load = "/signup_page"
    return { render = "pages.login_signup.login_signup_page" }
  end,
  signup_page = function()
    return { render = "pages.login_signup.signup.signup_page" }
  end,
  signup_complete = function(self)
    local user = Users:select("WHERE ?", db.clause({
      username = self.params.username,
      password = self.params.password,
      email = self.params.email
    }))
    if self.params.password == self.params.confirm_password then
      if next(user) == nil then
        Users:create({
          username = self.params.username,
          password = self.params.password,
          email = self.params.email
        })
        self.session.username = self.params.username
        self.session.logged_in = true
        return { render = "pages.login_signup.signup.signup_complete" }
      else
        return { redirect_to = self:url_for("signup") }
      end
    end
  end,
  logout = function(self)
    self.session.logged_in = false
    return { redirect_to = self:url_for("index") }
  end,
  delete_account = function(self)
    local user = Users:find({
      username = self.session.username
    })
    if next(user) ~= nil then
      user:delete(db.clause({
        username = self.session.username
      }))
      return { redirect_to = self:url_for("index") }
    end
  end
}
