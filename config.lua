---@type Config
local config = require("lapis.config")
local dotenv = require("lib.dotenv")
local env, err = dotenv.load()
-- if err then
--   print(err)
-- end

config("development", {
  port = "8080",
  code_cache = "off",
  num_workers = "1",
  sqlite = {
    database = env.get("DATABASE_URL"),
  }
})

config("production", {
  port = "8080",
  code_cache = "on",
  num_workers = "auto",
  sqlite = {
    database = env.get("DATABASE_URL"),
  }
})

-- print("Currently running on port: " .. config.get().port)
