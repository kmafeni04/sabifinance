local Model = require("lapis.db.model").Model
local db = require("lapis.db")

local Achievements, Achievements_mt = Model:extend("achievements")
local Users = Model:extend("users")

function Achievements_mt:create_achievements()
  local user = Users:find(db.clause({
    username = self.session.username
  }))
  Achievements:create({
    id = "1",
    name = "Too Consistent",
    description = "Achieve a streak of 10 days, consistently updating your transactions",
    completed = "false",
    user_id = user.id
  })
  Achievements:create({
    id = "2",
    name = "Profit Surge",
    description = "Have your income be more than your expense for at least a week",
    completed = "false",
    user_id = user.id
  })
  Achievements:create({
    id = "3",
    name = "Goal Getter",
    description = "Create and complete at least 5 goals",
    completed = "false",
    user_id = user.id
  })
  Achievements:create({
    id = "4",
    name = "Track Runner",
    description = "Record at least for transaction everyday for a week",
    completed = "false",
    user_id = user.id
  })
end

return Achievements
