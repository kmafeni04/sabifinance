local config = require("lapis.config")

config({ "development", "production" }, {
  server = "nginx",
  sqlite = {
    database = "app.sqlite",
  }
})

config("development", {
  code_cache = "off",
  num_workers = 1,
})

config("production", {
  code_cache = "on",
  num_workers = 2,
})
