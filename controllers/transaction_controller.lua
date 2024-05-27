local Users = require("models.users")
local Goals = require("models.goals")
local Transactions = require("models.transactions")
local Tasks = require("models.tasks")

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
    Tasks:update_tasks(self.session.username)
    return { render = "pages.home.dashboard.transaction.transaction_created" }
  end,
  delete_transaction = function(self)
    local transaction = Transactions:find(self.params.id)
    if transaction.type == "Goal" then
      local goal = Goals:find({ name = transaction.name })
      goal:update({
        current_amount = tonumber(goal.current_amount) - tonumber(transaction.amount),
        remaining_amount = tonumber(goal.remaining_amount + tonumber(transaction.amount)),
        weeks_left = tonumber(goal.weeks_left) + 1,
        progress = goal.progress - transaction.amount
      })
    end
    transaction:delete()
    Tasks:update_tasks(self.session.username)
    return { redirect_to = self:url_for("dashboard") }
  end
}
