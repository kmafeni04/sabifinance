-- local Model = require("lapis.db.model").Model
local Tasks = require("models.tasks")
local ngx = require("ngx")

return {

  tasks_page = function(self)
    self.tasks = Tasks:select()
    return { Tasks:create_tasks(self.session.username), render = "pages.home.tasks.tasks_page", layout = "home_layout" }
  end,
  tasks_delete = function()
    local tasks = Tasks:select()
    if next(tasks) ~= nil then
      ngx.timer.at(24 * 60 * 60, function()
        for _, task in pairs(tasks) do
          task:delete()
        end
      end)
    end
  end,
}
