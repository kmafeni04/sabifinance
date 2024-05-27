package = "personal-finance-tracker"
version = "dev-1"

source = {
  url = "https://github.com/kmafeni04/sabifinance.git"
}

description = {
  summary = "Lapis Application",
  homepage = "",
  license = ""
}

dependencies = {
  "lua ~> 5.1",
  "lapis == 1.16.0",
  "lsqlite3",
  "tableshape"
}

build = {
  type = "none"
}
