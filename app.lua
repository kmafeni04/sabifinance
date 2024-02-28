local lapis = require("lapis")
local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"

app:get("/", function()
  return { render = "pages.index" }
end)


return app
