local Model = require("lapis.db.model").Model
local Users = Model:extend("users")

return {
  index = function(self)
    self.session.username = "kmafeni04"
    self.users = Users:select()
    return { render = "pages.index" }
  end
}
