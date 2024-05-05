local Model = require("lapis.db.model").Model
local Tasks = require("models.tasks")

return {
  tasks_page = function(self)
    self.tasks = Tasks:select()
    return { Tasks:create_tasks(self.session.username), render = "pages.home.tasks.tasks_page" }
  end,
}
