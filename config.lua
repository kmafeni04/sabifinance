local config = require("lapis.config")

config("development", {
  server = "nginx",
  code_cache = "off",
  num_workers = "1",
  sqlite = {
    database = "app.sqlite",
  }
})

config("production", {
  num_workers = 4,
  code_cache = "on",
  sqlite = {
    database = "app.sqlite",
  }
})
