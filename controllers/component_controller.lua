local Transactions = require("models.transactions")
return {
  analytics_chart = function(self)
    self.transactions = Transactions:select()
    return { render = "components.analytics_chart" }
  end,
}
