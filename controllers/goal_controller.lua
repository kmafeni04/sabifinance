local Goals = require("models.goals")
local Users = require("models.users")
local Transactions = require("models.transactions")
local Tasks = require("models.tasks")
local Achievements = require("models.achievements")

return {
  goal_page = function(self)
    local user = Users:find({
      username = self.session.username
    })
    self.goals = Goals:select({
      user_id = user.id
    })
    self.transactions = Transactions:select({
      user_id = user.id
    })
    local balance = 0
    local income = 0
    local expense = 0
    local transactions = self.transactions
    for _, transaction in pairs(transactions) do
      if transaction.type == "Income" then
        income = income + tonumber(transaction.amount)
        balance = balance + tonumber(transaction.amount)
      elseif transaction.type == "Expense" then
        expense = expense + tonumber(transaction.amount)
        balance = balance - tonumber(transaction.amount)
      elseif transaction.type == "Goal" then
        expense = expense + tonumber(transaction.amount)
        balance = balance - tonumber(transaction.amount)
      end
    end

    self.balance = balance
    return { render = "pages.home.goals.goals_page", layout = "home_layout" }
  end,
  new_goal = function()
    return { render = "pages.home.goals.new_goal" }
  end,
  goal_created = function(self)
    Goals:create_goal(self.session.username, self.params.name, self.params.description, self.params.end_date,
      self.params.amount)
    Tasks:update_tasks(self.session.username)
    Achievements:update_achievements(self.session.username)
    return { render = "pages.home.goals.goal_created" }
  end,
  delete_goal = function(self)
    Goals:delete_goal(self.params.id)
    Tasks:update_tasks(self.session.username)
    Achievements:update_achievements(self.session.username)
    return { redirect_to = self:url_for("goals") }
  end,
  edit_goal = function(self)
    self.goal = Goals:find(self.params.id)
    return { render = "pages.home.goals.edit_goal" }
  end
}
