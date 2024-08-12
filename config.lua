---@type Config
local config = require("lapis.config")

config({ "development", "production" }, {
  num_workers = "auto",
})

config("development", {
  code_cache = "off",
  sqlite = {
    database = "app.sqlite",
  }
})

config("production", {
  code_cache = "on",
  sqlite = {
    database = os.getenv("DATABASE_URL")
  }
})
