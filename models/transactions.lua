local Users = require("models.users")

local Model = require("lapis.db.model").Model
local Transactions, Transactions_mt = Model:extend("transactions")



function Transactions_mt:create_goal_transaction(username, transaction_name, transaction_amount, transaction_description)
  local user_info = Users:get_user_info(username)
  Transactions:create({
    date = os.date("%Y-%m-%d"),
    name = transaction_name,
    amount = transaction_amount,
    type = "Goal",
    description = transaction_description,
    user_id = user_info.id
  })
end

return Transactions
