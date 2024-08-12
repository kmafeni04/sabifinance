local Users = require("models.users")
local db = require("lapis.db")

return {
  login = function(self)
    self.load = "/login_page"
    ngx.say("The var is " .. os.getenv("PGUSER"))
    print("The PG variable is " .. (os.getenv("PGDATABSE") or "none"))
    return { render = "pages.login_signup.login_signup_page" }
  end,
  login_page = function()
    return { render = "pages.login_signup.login.login_page" }
  end,
  login_post = function(self)
    local user = Users:select(db.clause({
      username = self.params.username,
      password = self.params.password
    }))
    if next(user) ~= nil then
      self.session.username = self.params.username
      self.session.logged_in = true
      return { redirect_to = self:url_for("dashboard") }
    else
      return { redirect_to = self:url_for("login") }
    end
  end,
  signup = function(self)
    self.load = "/signup_page"
    return { render = "pages.login_signup.login_signup_page" }
  end,
  signup_page = function(self)
    self.errors = {}
    return { render = "pages.login_signup.signup.signup_page" }
  end,
  signup_complete = function(self)
    self.errors = {}
    local user_info = Users:get_user_info(self.params.username)
    if string.len(self.params.username) < 5 then
      table.insert(self.errors, "Username must be more than 5 characters")
    end
    if user_info ~= nil then
      table.insert(self.errors, "This user already exists")
    end
    if self.params.password ~= self.params.confirm_password then
      table.insert(self.errors, "Passwords do not match")
    end
    if #self.errors > 0 then
      return { render = "pages.login_signup.signup.signup_page" }
    else
      Users:create_user(self.params.username, self.params.email, self.params.password)
      self.session.username = self.params.username
      self.session.logged_in = true
      return { render = "pages.login_signup.signup.signup_complete" }
    end
  end,
  logout = function(self)
    self.session.username = nil
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
      self.session.logged_in = false
      self.session.username = nil
      return { render = "pages.index" }
    end
  end
}
