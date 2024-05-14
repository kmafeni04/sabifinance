-- local Model = require("lapis.db.model").Model
local Tasks = require("models.tasks")
local ngx = require("ngx")

return {
  tasks_page = function(self)
    Tasks:create_tasks(self.session.username)
    self.tasks = Tasks:select()
    return { render = "pages.home.tasks.tasks_page", layout = "home_layout" }
  end,
  tasks_delete = function()
    local tasks = Tasks:select()
    if next(tasks) ~= nil then
      local currentHour = tonumber(os.date("%H"))
      if currentHour == 0 then
        for _, task in pairs(tasks) do
          task:delete()
        end
      end
    end
  end,
}
