local Model = require("lapis.db.model").Model
local Goals, Goals_mt = Model:extend("goals")

local db = require("lapis.db")

local Users = require("models.users")
local Transactions = require("models.transactions")

function Goals_mt:create_goal(username, goal_name, goal_description, goal_end_date, goal_amount)
  local user_info = Users:get_user_info(username)
  Goals:create {
    name = goal_name,
    description = goal_description,
    end_date = goal_end_date,
    amount_per_week = goal_amount,
    current_amount = goal_amount,
    date_created = os.date("%Y-%m-%d"),
    progress = goal_amount,
    completed = "false",
    user_id = user_info.id,
  }
  Transactions:create_transaction(username, goal_name, goal_amount, goal_description)
end

function Goals_mt:delete_goal(goal_id)
  local goal = Goals:find(goal_id)
  local transactions = Transactions:select(db.clause {
    name = goal.name,
  })
  for _, transaction in pairs(transactions) do
    transaction:delete()
  end

  goal:delete()
end

return Goals
