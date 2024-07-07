local db = require("lapis.db")

local Users = require("models.users")
local Transactions = require("models.transactions")

return {
  home = function(self)
    return { render = "dashboard" }
  end,
  dashboard = function(self)
    self.username = self.session.username

    local user_info = Users:get_user_info(self.username)
    self.transactions = Transactions:select(db.clause({
      user_id = user_info.id
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
    self.income = income
    self.expense = expense

    return { render = "pages.home.dashboard.dashboard_page", layout = "home_layout" }
  end,
  settings = function(self)
    local user = Users:get_user_info(self.session.username)
    self.errors = {}
    self.to_render = false
    self.username = user.username
    self.email = user.email
    self.password = user.password
    return { render = "pages.home.settings.settings_page", layout = "home_layout" }
  end,
  settings_post = function(self)
    self.errors = {}
    local user = Users:get_user_info(self.session.username)
    if self.params.password == self.params.confirm_password then
      self.to_render = false
      user:update({
        username = self.params.username,
        email = self.params.email,
        password = self.params.password
      })
      self.session.username = self.params.username
      return { redirect_to = self:url_for("settings") }
    else
      self.to_render = true
      table.insert(self.errors, "Passwords do not match")
      self.username = user.username
      self.email = user.email
      self.password = user.password
      return { render = "pages.home.settings.settings_page" }
    end
  end
}
