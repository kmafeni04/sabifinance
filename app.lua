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
  Current = "/dashboard"
  return { render = "pages.home" }
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

app:get("/dashboard", function(self)
  self.params.username = "Kome"
  Username = self.params.username
  return { render = "page_addons.dashboard" }
end)


app:get("/achievements", function()
  return { render = "page_addons.achievements" }
end)

--- components ---


return app
