local Model = require("lapis.db.model").Model

local Users = require("models.users")
local Goals = require("models.goals")

local Achievements, Achievements_mt = Model:extend("achievements")

function Achievements_mt:create_achievements(username)
  local achievements = Achievements:select()
  if next(achievements) == nil then
    local user = Users:find({
      username = username
    })
    Achievements:create({
      name = "First of many",
      description = "Create and complete your first goal",
      progress = 0,
      total = 1,
      user_id = user.id
    })
    Achievements:create({
      name = "Goal Getter",
      description = "Create and complete 3 goals",
      progress = 0,
      total = 3,
      user_id = user.id
    })
    Achievements:create({
      name = "An eye for goal",
      description = "Create and complete 5 goals",
      progress = 0,
      total = 5,
      user_id = user.id
    })
  end
end

function Achievements_mt:update_achievements(username)
  local user_info = Users:get_user_info(username)
  local achievements = Achievements:select({ user_id = user_info.id })
  local goals = Goals:select("where progress >= total_amount")
  for _, achievement in ipairs(achievements) do
    achievement:update({ progress = tonumber(#goals) })
  end
end

return Achievements
