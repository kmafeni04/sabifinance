local Model = require("lapis.db.model").Model
local db = require("lapis.db")

local Users = require("models.users")
local Transactions = Model:extend("transactions")

return {
  new_transaction = function()
    return { render = "pages.home.dashboard.transaction.new_transaction" }
  end,
  new_transaction_post = function(self)
    local user_info = Users:get_user_info(self.session.username)
    Transactions:create({
      date = self.params.date,
      name = self.params.name,
      amount = self.params.amount,
      type = self.params.type,
      description = self.params.description,
      user_id = user_info.id
    })
    return { render = "pages.home.dashboard.transaction.transaction_created" }
  end,
  delete_transaction = function(self)
    local transaction = Transactions:find(self.params.id)
    transaction:delete()
    return { redirect_to = "/home/dashboard" }
  end
}
