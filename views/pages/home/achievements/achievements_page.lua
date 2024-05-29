local Widget = require("lapis.html").Widget

return Widget:extend(function(self)
  div({ class = "achievements" }, function()
    link({ rel = "stylesheet", href = "/static/CSS/achievements.css" })
    div({ class = "top" }, function()
      h2("Achievements")
      h4("View all user achievements")
    end)
    div({ class = "bottom" }, function()
      div({ class = "first-row ongoing" }, function()
        div({ class = "header" }, function()
          h3("Ongoing")
        end)
        div({ class = "horizontal-cards cards" }, function()
          for _, achievement in pairs(self.achievements) do
            if achievement.progress < achievement.total then
              div({ class = "card" }, function()
                h3(achievement.name)
                p(achievement.description)
              end)
            end
          end
        end)
      end)
      div({ class = "second-row" }, function()
        div({ class = "header" }, function()
          h3("Completed")
        end)
        div({ class = "horizontal-cards cards" }, function()
          local none_completed = false
          for _, achievement in pairs(self.achievements) do
            if achievement.progress >= achievement.total then
              div({ class = "card" }, function()
                h3(achievement.name)
                p(achievement.description)
              end)
              none_completed = true
            else
              if none_completed == false then
                div({ class = "card" }, function()
                  h2("No achievements completed")
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
