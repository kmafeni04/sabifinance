local Model = require("lapis.db.model").Model
local Users = require("models.users")
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
    if self.params.password == self.params.confirm_password then
      local user_info = Users:get_user_info(self.params.username)
      if user_info == nil then
        Users:create_user(self.params.username, self.params.email, self.params.password)
        self.session.username = self.params.username
        self.session.logged_in = true
        return { render = "pages.login_signup.signup.signup_complete" }
      else
        return { redirect_to = self:url_for("signup") }
      end
    else
      return { redirect_to = self:url_for("signup") }
    end
  end,
  logout = function(self)
    self.session.logged_in = false
    self.session.username = nil
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
      self.session.logged_in = false
      self.session.username = nil
      return { render = "pages.index" }
    end
  end
}
