local Model = require("lapis.db.model").Model
local Goals, Goals_mt = Model:extend("goals")

local db = require("lapis.db")

local Users = require("models.users")
local Transactions = require("models.transactions")

function Goals_mt:create_goal(username, goal_name, goal_description, goal_end_date, goal_amount)
  local user_info = Users:get_user_info(username)
  local end_date_time = os.time { year = tonumber(goal_end_date:sub(1, 4)), month = tonumber(goal_end_date:sub(6, 7)), day = tonumber(goal_end_date:sub(9, 10)) }
  local date_created_time = os.time()
  local difference_seconds = end_date_time - date_created_time
  local weeks_left = math.floor(difference_seconds / (7 * 24 * 60 * 60) + 0.5)
  Goals:create {
    name = goal_name,
    description = goal_description,
    end_date = goal_end_date,
    date_created = date_created_time,
    amount_per_week = goal_amount,
    current_amount = goal_amount,
    remaining_amount = (goal_amount * weeks_left) - goal_amount,
    total_amount = goal_amount * weeks_left,
    weeks_left = weeks_left,
    progress = goal_amount,
    user_id = user_info.id,
  }
  Transactions:create_goal_transaction(username, goal_name, goal_amount, goal_description)
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
