local db = require("lapis.db")
local Model = require("lapis.db.model").Model
local Users = Model:extend("users")
local Transactions = Model:extend("transactions")
local Goals = Model:extend("goals")

return {
  goal_page = function(self)
    local user = Users:find(db.clause({
      username = self.session.username
    }))
    self.goals = Goals:select(db.clause {
      user_id = user.id
    })
    -- self.text = math.floor((os.time(os.date()) - os.time()) / (7 * 24 * 60 * 60))
    self.transactions = Transactions:select(db.clause({
      user_id = user.id
    }))
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
    return { render = "pages.home.goals.goals_page" }
  end,
  new_goal = function()
    return { render = "pages.home.goals.new_goal" }
  end,
  goal_created = function(self)
    local user = Users:find(db.clause({
      username = self.session.username
    }))
    Goals:create {
      name = self.params.name,
      description = self.params.description,
      end_date = self.params.end_date,
      amount = self.params.amount,
      user_id = user.id
    }
    Transactions:create({
      date = os.date("%Y-%m-%d"),
      name = self.params.name,
      amount = self.params.amount,
      type = "Goal",
      description = self.params.description,
      user_id = user.id
    })
    return { render = "pages.home.goals.goal_created" }
  end,
  delete_goal = function(self)
    local goal = Goals:find(self.params.id)
    goal:delete()
    return { redirect_to = self:url_for("goals") }
  end,
  edit_goal = function(self)
    self.goal = Goals:find(self.params.id)
    return { render = "pages.home.goals.edit_goal" }
  end
}
