local Model = require("lapis.db.model").Model
local db = require("lapis.db")

local Tasks, Tasks_mt = Model:extend("tasks")
local Users = Model:extend("users")

function Tasks_mt:create_tasks(username)
  local tasks = Tasks:select()
  if next(tasks) == nil then
    local user = Users:find(db.clause({
      username = username
    }))
    Tasks:create({
      id = "1",
      name = "No-Spend Day",
      description = "Challenge yourself to avoid spending any money",
      progress = "0",
      total = "24",
      completed = "false",
      user_id = user.id
    })
    Tasks:create({
      id = "2",
      name = "And 1",
      description = "Record at least one transaction for the day",
      progress = "0",
      total = "1",
      completed = "false",
      user_id = user.id
    })
    Tasks:create({
      id = "3",
      name = "3 of The Best",
      description = "Record at least 3 transactions for the day",
      progress = "0",
      total = "3",
      completed = "false",
      user_id = user.id
    })
    Tasks:create({
      id = "4",
      name = "From Deep",
      description = "Record at least 5 transactions for the day",
      progress = "0",
      total = "5",
      completed = "false",
      user_id = user.id
    })
  end
end

return Tasks
