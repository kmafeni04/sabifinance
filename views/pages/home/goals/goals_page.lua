local Widget = require("lapis.html").Widget

return Widget:extend(function(self)
  link({ rel = "stylesheet", href = "/static/CSS/goals.css" })
  div({ class = "header" }, function()
    h3("Ongoing")
    button({ ["hx-get"] = "/new_goal", ["hx-target"] = ".new-goal-container" }, "New goal +")
  end)
  div({ class = "new-goal-container" })
  div({ class = "first-row" }, function()
    render("views.components.card_bills", { header = "Balance", paragraph = self.balance })
    div({ class = "horizontal-cards cards" }, function()
      if next(self.goals) ~= nil then
        for _, goal in pairs(self.goals) do
          local date_string = goal.end_date
          local year, month, day = date_string:match("(%d+)-(%d+)-(%d+)")
          local dateTable = { year = tonumber(year), month = tonumber(month), day = tonumber(day), }
          local timestamp = os.time(dateTable)
          local weeks = math.floor((timestamp - os.time()) / (7 * 24 * 60 * 60))
          local goal_max = goal.amount * weeks
          if goal.amount ~= goal_max then
            div({ class = "card goal-card" }, function()
              div({ class = "card-top" }, function()
                div(function()
                  h3({ class = "card-header" }, goal.name)
                  p({ class = "card-paragraph" }, goal.description)
                end)
                button(
                  { class = "card-button", ["hx-get"] = "/edit_goal/" .. goal.id, ["hx-target"] = ".new-goal-container" },
                  "Edit goal")
              end)
              div({ class = "card-body" }, function()
                div({
                  class = "duration",
                  function()
                    p({ class = "duration-header" }, "Duration")
                    p({ class = "duration-paragraph" }, function()
                      if weeks <= 1 then
                        weeks = 1
                        text("<1 week")
                      else
                        text(weeks .. " week(s)")
                      end
                    end)
                  end
                })
                div({ class = "amount" }, function()
                  p({ class = "amount-header" }, "Amount /w")
                  p({ class = "amount-paragraph" }, "₦ " .. goal.amount)
                end)
              end)
              div({ class = "card-bottom" }, function()
                div({ class = "progress" }, function()
                  h4({ class = "progress-bar-label" }, "Progress:")
                  progress({ value = goal.amount, max = goal_max })
                  div({ class = "progress-details" }, function()
                    p({ class = "amount-remainig" }, function()
                      b("Remaining:")
                      br()
                      text("₦ " .. goal_max - goal.amount)
                    end)
                    p(b(string.format("%.2f", goal.amount / goal_max * 100) .. "%"))
                    p({ class = "current-amount" }, function()
                      b("Current:")
                      br()
                      text("₦ " .. goal.amount)
                    end)
                  end)
                end)
                button({
                  class = "delete-goal",
                  ["hx-get"] = "/delete_goal/" .. goal.id,
                  ["hx-confirm"] = "Are you sure you would like to delete this goal?",
                  ["hx-target"] = ".goals",
                  ["hx-swap"] = "outerHTML"
                }, "Delete Goal")
              end)
            end)
          end
        end
      else
        div({ class = "card no-goals-created" }, function()
          h2("Create a new goal")
          button({ ["hx-get"] = "/new_goal", ["hx-target"] = ".new-goal-container" }, "New goal +")
        end)
      end
    end)
  end)
  div({ class = "second-row" }, function()
    div({ class = "header" }, h3("Completed"))
    div({ class = "horizontal-cards cards" }, function()
      if next(self.goals) ~= nil then
        for _, goal in pairs(self.goals) do
          local date_string = goal.end_date
          local year, month, day = date_string:match("(%d+)-(%d+)-(%d+)")
          local dateTable = { year = tonumber(year), month = tonumber(month), day = tonumber(day), }
          local timestamp = os.time(dateTable)
          local weeks = math.floor((timestamp - os.time()) / (7 * 24 * 60 * 60))
          local goal_max = goal.amount * weeks
          if goal.amount == goal_max then
            div({ class = "card" }, function()
              div({ class = "card-top" }, function()
                div(function()
                  h3({ class = "card-header" }, "Goal Name")
                  p({ class = "card-paragraph" }, "Goal Desc")
                end)
                button("Redo Goal")
              end)
              div({ class = "card-body" }, function()
                div({ class = "duration" }, function()
                  p({ class = "duration-header" }, "Duration:")
                  p({ class = "duration-paragraph" }, "2 months")
                end)
                div({ class = "amount" }, function()
                  p({ class = "amount-header" }, "Amount /w:")
                  p({ class = "amount-paragraph" }, "₦ 3000")
                end)
              end)
              div({ class = "card-bottom" }, function()
                div({ class = "progress" }, function()
                  h4({ class = "progress-bar-label" }, "Progress:")
                  progress({ value = "3000", max = "3000" })
                  div({ class = "progress-details" }, function()
                    p({ class = "amount-remaining" }, function()
                      b("Remaining")
                      br()
                      text("₦ 0")
                    end)
                    p(b("100%"))
                    p({ class = "current-amount" }, function()
                      b("Current:")
                      br()
                      text("₦ 3000")
                    end)
                  end)
                end)
              end)
            end)
          end
        end
      else
        div({ class = "card non-completed" }, function()
          h3("No goals completed yet")
        end)
      end
    end)
  end)
end)
