local lapis = require("lapis")
local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"


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

app:get("/achievements", function()
  return { render = "page_addons.achievements" }
end)

app:get("/goals", function()
  return { render = "page_addons.goals" }
end)
app:get("/analytics", function()
  return { render = "page_addons.analytics" }
end)

app:get("/analytics_chart", function()
  return { render = "page_addons.analytics_chart" }
end)

--- components ---

app:get("/bills_card1", function()
  Header = "Balance"
  Paragraph = "123456"
  return { render = "components.dashboard_card_bills"}
end)

app:get("/bills_card2", function()
  Header = "Income"
  Paragraph = "123456"
  return { render = "components.dashboard_card_bills" }
end)

app:get("/bills_card3", function()
  Header = "Expenses"
  Paragraph = "123456"
  return { render = "components.dashboard_card_bills" }
end)

app:get("/home_content_dashboard", function()
  Current = "dashboard"
  Sub_heading = "Dashboard"
  Sub_heading_desc = "Welcome, "
  return { render = "components.home_content" }
end)

app:get("/home_content_goals", function()
  Current = "goals"
  Sub_heading = "Goals"
  Sub_heading_desc = "Manage your goals"
  return { render = "components.home_content" }
end)

app:get("/home_content_achievements", function()
  Current = "achievements"
  Sub_heading = "Achievments"
  Sub_heading_desc = "View your achievements"
  return { render = "components.home_content" }
end)

app:get("/home_content_analytics", function()
  Current = "analytics"
  Sub_heading = "Analytics"
  Sub_heading_desc = "Analyze your balance"
  return { render = "components.home_content" }
end)

app:get("/home_content_settings", function()
  Current = "settings"
  Sub_heading = "Settings"
  Sub_heading_desc = "Manage your user preferences"
  return { render = "components.home_content" }
end)

return app
