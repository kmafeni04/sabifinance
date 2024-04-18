local lapis = require("lapis")
local app = lapis.Application()
local db = require("lapis.db")
local Model = require("lapis.db.model").Model

app:enable("etlua")
app.layout = require "views.layout"

local Users = Model:extend("users")
local Transactions = Model:extend("transactions")

--- routes ---

--- gets ---

app:get("index", "/", function(self)
  self.session.username = "kmafeni04"
  self.users = Users:select()
  return { render = "pages.index" }
end)

app:get("login", "/login", function(self)
  self.load = "/login_addon"
  return { render = "pages.login_signup" }
end)

app:get("signup", "/signup", function(self)
  self.load = "/signup_addon"
  return { render = "pages.login_signup" }
end)

app:get("home", "/home", function(self)
  if self.session.logged_in == true then
    self.username = self.session.username
    return { render = "pages.home" }
  else
    return { redirect_to = self:url_for("index") }
  end
end
)

app:get("/logout", function(self)
  self.session.logged_in = false
  return { redirect_to = self:url_for("index") }
end)

app:get("/delete_account", function(self)
  local user = Users:find({
    username = self.session.username
  })
  if next(user) ~= nil then
    user:delete(db.clause({
      username = self.session.username
    }))
    return { redirect_to = self:url_for("index") }
  end
end)


--- posts ---

app:post("/signup_complete", function(self)
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
      return { render = "page_addons.signup_complete" }
    else
      return { redirect_to = self:url_for("signup") }
    end
  end
end)

app:post("home", "/home", function(self)
  local user = Users:select("WHERE ?", db.clause({
    username = self.params.username,
    password = self.params.password
  }))
  if next(user) ~= nil then
    self.session.username = self.params.username
    self.session.logged_in = true
    return { render = "pages.home" }
  else
    return { redirect_to = self:url_for("login") }
  end
end)

app:post("/new_transaction", function(self)
  Transactions:create({
    date = self.params.date,
    name = self.params.name,
    amount = self.params.amount,
    type = self.params.type,
    description = self.params.description
  })


  return { render = "page_addons.transaction_created" }
end)

--- addons ---

app:get("/login_addon", function()
  return { render = "page_addons.login" }
end)

app:get("/signup_addon", function()
  return { render = "page_addons.signup" }
end)

app:get("/dashboard", function(self)
  self.test = self.params.transaction_name
  self.transactions = Transactions:select()
  return { render = "page_addons.dashboard" }
end)

app:get("/dashboard/new_transaction", function()
  return { render = "page_addons.new_transaction" }
end)

app:get("/delete_transaction/:name", function(self)
  Transactions:delete(db.clause({
    name = self.params.name
  }))
end)

app:get("/achievements", function()
  return { render = "page_addons.achievements" }
end)

app:get("/goals", function()
  return { render = "page_addons.goals" }
end)

app:get("/goals/new_goal", function()
  return { render = "page_addons.new_goal" }
end)

app:get("/analytics", function()
  return { render = "page_addons.analytics" }
end)

app:get("/analytics_chart", function()
  return { render = "page_addons.analytics_chart" }
end)

app:get("/settings", function(self)
  local user = Users:select(db.clause({
    username = self.session.username
  }))
  self.username = user[1].username
  self.email = user[1].email
  self.password = user[1].password
  return { render = "page_addons.settings" }
end)

--- components ---

app:get("/home_content_dashboard", function(self)
  self.current = "dashboard"
  self.sub_heading = "Dashboard"
  self.sub_heading_desc = "Welcome, " .. tostring(self.session.username)
  return { render = "components.home_content" }
end)

app:get("/home_content_goals", function(self)
  self.current = "goals"
  self.sub_heading = "Goals"
  self.sub_heading_desc = "Manage your goals"
  return { render = "components.home_content" }
end)

app:get("/home_content_achievements", function(self)
  self.current = "achievements"
  self.sub_heading = "Achievments"
  self.sub_heading_desc = "View your achievements"
  return { render = "components.home_content" }
end)

app:get("/home_content_analytics", function(self)
  self.current = "analytics"
  self.sub_heading = "Analytics"
  self.sub_heading_desc = "Analyze your balance"
  return { render = "components.home_content" }
end)

app:get("/home_content_settings", function(self)
  self.current = "settings"
  self.sub_heading = "Settings"
  self.sub_heading_desc = "Manage your user preferences"
  return { render = "components.home_content" }
end)

return app
