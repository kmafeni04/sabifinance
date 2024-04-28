local lapis = require("lapis")
local app = lapis.Application()
local db = require("lapis.db")
local Model = require("lapis.db.model").Model


app:enable("etlua")
app.layout = require "views.layout"

local Users = Model:extend("users", {
  relations = {
    { "transactions", has_many = "Transactions" },
    { "goals",        has_many = "Goals" }
  }
})
local Transactions = Model:extend("transactions", {
  relations = {
    { "user", belongs_to = "Users" }
  }
})
local Goals = Model:extend("goals", {
  relations = {
    { "user", belongs_to = "Users" }
  }
})

--- routes ---

--- index ---

app:get("index", "/", function(self)
  self.session.username = "kmafeni04"
  self.users = Users:select()
  return { render = "pages.index" }
end)

-------------

--- login ---

app:get("login", "/login", function(self)
  self.load = "/login_page"
  return { render = "pages.login_signup.login_signup_page" }
end)

app:get("/login_page", function()
  return { render = "pages.login_signup.login.login_page" }
end)

------------

--- signup ---

app:get("signup", "/signup", function(self)
  self.load = "/signup_page"
  return { render = "pages.login_signup.login_signup_page" }
end)

app:get("/signup_page", function()
  return { render = "pages.login_signup.signup.signup_page" }
end)

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
      return { render = "pages.login_signup.signup.signup_complete" }
    else
      return { redirect_to = self:url_for("signup") }
    end
  end
end)

-------------

--- home ---

app:get("home", "/home/:page", function(self)
  if self.session.logged_in == true then
    self.username = self.session.username
    self.page = self.params.page
    return { render = "pages.home.home_page" }
  else
    return { redirect_to = self:url_for("index") }
  end
end
)

--@CHECK remove "WHERE ?" from the front of db.clause
app:post("/home", function(self)
  local user = Users:select(db.clause({
    username = self.params.username,
    password = self.params.password
  }))
  if next(user) ~= nil then
    self.page = "dashboard"
    self.session.username = self.params.username
    self.session.logged_in = true
    return { render = "pages.home.home_page" }
  else
    return { redirect_to = self:url_for("login") }
  end
end)

-----------

--- settings ---

app:get("/settings", function(self)
  local user = Users:select(db.clause({
    username = self.session.username
  }))
  self.username = user[1].username
  self.email = user[1].email
  self.password = user[1].password
  return { render = "pages.home.settings.settings_page" }
end)

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

----------------


--- dashboard ---

app:get("/dashboard", function(self)
  self.test = self.params.transaction_name
  self.transactions = Transactions:select()
  return { render = "pages.home.dashboard.dashboard_page" }
end)

app:post("/new_transaction", function(self)
  local user = Users:select(db.clause({
    username = self.session.username
  }))
  Transactions:create({
    date = self.params.date,
    name = self.params.name,
    amount = self.params.amount,
    type = self.params.type,
    description = self.params.description,
    user_id = user[1].id
  })
  return { render = "pages.home.dashboard.transaction.transaction_created" }
end)

app:get("/dashboard/new_transaction", function()
  return { render = "pages.home.dashboard.transaction.new_transaction" }
end)

app:get("/delete_transaction/:name", function(self)
  Transactions:delete(db.clause({
    name = self.params.name
  }))
end)

----------------

--- achievements ---

app:get("/achievements", function()
  return { render = "pages.home.achievements.achievements_page" }
end)

-------------------

--- goals ---

app:get("/goals", function(self)
  self.goals = Goals:select()
  return { render = "pages.home.goals.goals_page" }
end)

app:get("/new_goal", function()
  return { render = "pages.home.goals.new_goal" }
end)

app:post("/goal_created", function(self)
  local user = Users:select(db.clause({
    username = self.session.username
  }))
  Goals:create {
    name = self.params.name,
    description = self.params.description,
    end_date = self.params.end_date,
    amount = self.params.amount,
    user_id = user[1].id
  }
  return { render = "pages.home.goals.goal_created" }
end)

------------

--- analytics ---

app:get("/analytics", function(self)
  self.transactions = Transactions:select()
  return { render = "pages.home.analytics.analytics_page" }
end)


----------------


--- components ---

app:get("/analytics_chart", function()
  return { render = "components.analytics_chart" }
end)

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
