local Widget = require("lapis.html").Widget

return Widget:extend(function(self)
  div({ class = "tasks" }, function()
    div({ class = "top" }, function()
      h2("Daily Tasks")
      h4("View all your daily tasks")
    end)
    div({ class = "bottom" }, function()
      link({ rel = "stylesheet", href = "/static/CSS/tasks.css" })
      div({ class = "first-row" }, function()
        h3({ class = "header" }, "Ongoing")
        div({ class = "horizontal-cards ongoing" }, function()
          for _, task in pairs(self.tasks) do
            if task.progress < task.total then
              div({ class = "card" }, function()
                h3(task.name)
                p(task.description)
                p(function()
                  b("Progress:")
                end)
                progress({ value = task.progress, max = task.total })
                div({ class = "progress-details" }, function()
                  div(function()
                    label(function() b("Remaining:") end)
                    p(task.total - task.progress)
                  end)
                  local task_percentage = math.floor((task.total / task.progress) * 10)
                  print(task_percentage)
                  if task_percentage == math.huge then
                    task_percentage = 0
                  end
                  p(function() b(task_percentage .. "%") end)
                  div(function()
                    label(function() b("Current:") end)
                    p(task.progress)
                  end)
                end)
              end)
            end
          end
        end)
      end)
      div({ class = "second-row" }, function()
        h3({ class = "header" }, "Completed")
        div({ class = "horizontal-cards completed" }, function()
          local none_completed = false
          for _, task in pairs(self.tasks) do
            if task.progress == task.total then
              div({ class = "card" }, function()
                h3(task.name)
                p(task.description)
                progress({ value = task.progress, max = task.total })
              end)
            else
              if none_completed == false then
                div({ class = "card none-completed" }, function()
                  h2("No tasks completed")
                end)
                none_completed = true
              end
            end
          end
        end)
      end)
    end)
  end)
end)
