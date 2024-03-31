local lapis = require("lapis")
local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"


Username = nil or "kmafeni04"
Email = nil or "komemafeni944@gmail.com"
Password = nil or "aPassword*"

--- routes ---

app:get("/", function()
  return { render = "pages.index" }
end)

app:get("/login", function()
  Load = "/login_addon"
  return { render = "pages.login_signup" }
end)

app:get("/signup", function()
  Load = "/signup_addon"
  return { render = "pages.login_signup" }
end)

app:get("/home", function()
  return { render = "pages.home" }
end)

app:get("/settings", function()
  return { render = "pages.settings" }
end)

--- posts ---

app:post("/signup_complete", function()
  return { render = "page_addons.signup_complete" }
end)

app:post("/home", function()
  return { render = "pages.home" }
end)

--- addons ---

app:get("/login_addon", function()
  return { render = "page_addons.login" }
end)

app:get("/signup_addon", function()
  return { render = "page_addons.signup" }
end)

app:get("/dashboard", function()
  return { render = "page_addons.dashboard" }
end)

app:get("/dashboard/new_transaction", function()
  return { render = "page_addons.new_transaction"}
end)

app:get("/achievements", function()
  return { render = "page_addons.achievements" }
end)

app:get("/goals", function()
  return { render = "page_addons.goals" }
end)

app:get("/goals/new_goal", function()
  return { render = "page_addons.new_goal"}
end)

app:get("/analytics", function()
  return { render = "page_addons.analytics" }
end)

app:get("/analytics_chart", function()
  return { render = "page_addons.analytics_chart" }
end)

--- components ---

app:get("/bills_card_balance", function(self)
  self.header = "Balance"
  self.paragraph = "123456"
  return { render = "components.dashboard_card_bills"}
end)

app:get("/bills_card_income", function(self)
  self.header = "Income"
  self.paragraph = "123456"
  return { render = "components.dashboard_card_bills" }
end)

app:get("/bills_card_expenses", function(self)
  self.header = "Expenses"
  self.paragraph = "123456"
  return { render = "components.dashboard_card_bills" }
end)

app:get("/home_content_dashboard", function(self)
  self.current = "dashboard"
  self.sub_heading = "Dashboard"
  self.sub_heading_desc = "Welcome, ".. (Username or "User")
  return { render = "components.home_content" }
end)

app:get("/home_content_goals", function(self)
  self.current= "goals"
  self.sub_heading = "Goals"
  self.sub_heading_desc = "Manage your goals"
  return { render = "components.home_content" }
end)

app:get("/home_content_achievements", function(self)
  self.current= "achievements"
  self.sub_heading = "Achievments"
  self.sub_heading_desc = "View your achievements"
  return { render = "components.home_content" }
end)

app:get("/home_content_analytics", function(self)
  self.current= "analytics"
  self.sub_heading = "Analytics"
  self.sub_heading_desc = "Analyze your balance"
  return { render = "components.home_content" }
end)

app:get("/home_content_settings", function(self)
  self.current= "settings"
  self.sub_heading = "Settings"
  self.sub_heading_desc = "Manage your user preferences"
  return { render = "components.home_content" }
end)

return app
