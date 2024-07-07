local Transactions = require("models.transactions")
local Users = require("models.users")

local Model = require("lapis.db.model").Model
local Tasks, Tasks_mt = Model:extend("tasks")


function Tasks_mt:create_tasks(username)
  local tasks = Tasks:select()
  if next(tasks) == nil then
    local user_info = Users:get_user_info(username)

    Tasks:create({
      name = "At least you tried",
      description = "Record at least one transaction",
      progress = 0,
      total = 1,
      user_id = user_info.id
    })
    Tasks:create({
      name = "3 of The Best",
      description = "Record at least 3 transactions",
      progress = 0,
      total = 3,
      user_id = user_info.id
    })
    Tasks:create({
      name = "Deep Pockets",
      description = "Record at least 5 transactions",
      progress = 0,
      total = 5,
      user_id = user_info.id
    })
  end
end

function Tasks_mt:update_tasks(username)
  local user_info = Users:get_user_info(username)
  local tasks = Tasks:select({ user_id = user_info.id })
  local transactions = Transactions:select()
  for _, task in ipairs(tasks) do
    task:update({ progress = tonumber(#transactions) })
  end
end

return Tasks
