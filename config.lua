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
  code_cache = "on",
  num_workers = 4,
  sqlite = {
    database = "app.sqlite",
  }
})
