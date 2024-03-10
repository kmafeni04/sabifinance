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
  return { render = "components.dashboard_card_bills" }
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

for i = 1,3  do
	print(i)
end


return app
