local config = require("lapis.config")

config({ "development", "production" }, {
  server = "nginx",
})

config("development", {
  code_cache = "off",
  num_workers = 1,
  sqlite = {
    database = "app.sqlite",
  }
})

config("production", {
  code_cache = "on",
  num_workers = 2,
  sqlite = {
    database = "app.sqlite",
  }
})
