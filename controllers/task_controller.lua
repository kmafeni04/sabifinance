local Tasks = require("models.tasks")

return {
  tasks_page = function(self)
    Tasks:create_tasks(self.session.username)
    self.tasks = Tasks:select()
    Tasks:update_tasks(self.session.username)
    return { render = "pages.home.tasks.tasks_page", layout = "home_layout" }
  end,
}
