local Model = require("lapis.db.model").Model
local db = require("lapis.db")

local Users = require("models.users")
local Transactions = Model:extend("transactions")
local Goals = Model:extend("goals")

return {
  home = function(self)
    if self.session.logged_in == true then
      self.username = self.session.username
      self.page = self.params.page
      return { render = "dashboard" }
    else
      return { redirect_to = self:url_for("index") }
    end
  end,
  home_post = function(self)
    local user = Users:select(db.clause({
      username = self.params.username,
      password = self.params.password
    }))
    if next(user) ~= nil then
      self.page = "dashboard"
      self.session.username = self.params.username
      self.session.logged_in = true
      return { redirect_to = self:url_for("dashboard") }
    else
      return { redirect_to = self:url_for("login") }
    end
  end,
  dashboard = function(self)
    self.username = self.session.username

    local user = Users:find(db.clause({
      username = self.session.username
    }))
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
    self.income = income
    self.expense = expense

    return { render = "pages.home.dashboard.dashboard_page", layout = "home_layout" }
  end,
  settings = function(self)
    local user = Users:find(db.clause({
      username = self.session.username
    }))
    self.username = user.username
    self.email = user.email
    self.password = user.password
    return { render = "pages.home.settings.settings_page", layout = "home_layout" }
  end
}
