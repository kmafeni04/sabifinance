local Widget = require("lapis.html").Widget

return Widget:extend(function(self)
  link({ rel = "stylesheet", href = "/static/CSS/tasks.css" })
  div({ class = "first-row" }, function()
    h3({ class = "header" }, "Ongoing")
    div({ class = "horizontal-cards ongoing" }, function()
      for _, task in pairs(self.tasks) do
        if task.progress ~= task.total then
          div({ class = "card" }, function()
            h3(task.name)
            p(task.description)
            p(b("Progress:"))
            progress({ value = task.progress, max = task.total })
            div({ class = "progress-details" }, function()

            end)
          end)
        end
      end
    end)
  end)
  div({ class = "second-row" }, function()
    h3({ class = "header" }, "Completed")
    div({ class = "cards completed" }, function()
      for _, task in pairs(self.tasks) do
        if task.progress == task.total then
          div({ class = "card" }, function()
            h3(task.name)
            p(task.description)
            progress({ value = task.progress, max = task.total })
          end)
        end
      end
    end)
  end)
  div({ class = "third-row" }, function()
    h3({ class = "header" }, "Streaks")
    div({ class = "streaks" }, function()
    end)
  end)
end)
