local Widget = require("lapis.html").Widget
local db = require("lapis.db")
local Model = require("lapis.db.model").Model
local Users = Model:extend("users")
local Transactions = Model:extend("transactions")
local Goals = Model:extend("goals")

return Widget:extend(function(self)
  div({ class = "goals" }, function()
    link({ rel = "stylesheet", href = "/static/CSS/goals.css" })
    div({ class = "top" }, function()
      h2("Goals")
      h4("View all your set goals")
    end)
    div({ class = "bottom" }, function()
      div({ class = "new-goal-container" })
      if next(self.goals) ~= nil then
        div({ class = "first-row" }, function()
          div({ class = "header" }, function()
            h3("Ongoing")
            button({ ["hx-get"] = "/new_goal", ["hx-target"] = ".new-goal-container" }, "New goal +")
          end)
          div({ class = "horizontal-cards cards ongoing" }, function()
            render("views.components.card_bills", { header = "Balance", paragraph = self.balance })
            local no_goal = false
            for _, goal in pairs(self.goals) do
              if goal.remaining_amount > 0 then
                div({ class = "card goal-card" }, function()
                  div({ class = "card-top" }, function()
                    div(function()
                      h3({ class = "card-header" }, goal.name)
                      p({ class = "card-paragraph" }, goal.description)
                    end)
                    button(
                      {
                        class = "card-button",
                        ["hx-get"] = "/edit_goal/" .. goal.id,
                        ["hx-target"] =
                        ".new-goal-container"
                      },
                      "Edit goal")
                  end)
                  div({ class = "card-body" }, function()
                    div({
                      class = "duration",
                      function()
                        p({ class = "duration-header" }, "Duration")
                        p({ class = "duration-paragraph" }, goal.weeks_left)
                      end
                    })
                    div({ class = "amount" }, function()
                      p({ class = "amount-header" }, "Amount /w")
                      p({ class = "amount-paragraph" }, "₦ " .. goal.amount_per_week)
                    end)
                  end)
                  div({ class = "card-bottom" }, function()
                    div({ class = "progress" }, function()
                      h4({ class = "progress-bar-label" }, "Progress:")
                      progress({ value = goal.progress, max = goal.total_amount })
                      div({ class = "progress-details" }, function()
                        p({ class = "amount-remainig" }, function()
                          b("Remaining:")
                          br()
                          if goal.remaining_amount < 0 then
                            goal.remaining_amount = 0
                          end
                          text("₦ " .. goal.remaining_amount)
                        end)
                        p(function()
                          b(math.floor((goal.total_amount / goal.current_amount) * 10) .. "%")
                        end)
                        p({ class = "current-amount" }, function()
                          b("Current:")
                          br()
                          text("₦ " .. goal.current_amount)
                        end)
                      end)
                    end)
                    button({
                      class = "delete-goal",
                      ["hx-get"] = "/delete_goal/" .. goal.id,
                      ["hx-confirm"] = "Are you sure you would like to delete this goal?",
                      ["hx-target"] = "body",
                      ["hx-swap"] = "outerHTML"
                    }, "Delete Goal")
                  end)
                end)
              else
                if no_goal == false then
                  div({ class = "none-completed card" }, function()
                    h2("Create a new goal")
                    button({ ["hx-get"] = "/new_goal", ["hx-target"] = ".new-goal-container" }, "New goal +")
                  end)
                  no_goal = true
                end
              end
            end
          end)
        end)
        div({ class = "second-row" }, function()
          div({ class = "header" }, function()
            h3("Completed")
          end)
        end)
        div({ class = "horizontal-cards cards" }, function()
          local none_completed = false
          for _, goal in pairs(self.goals) do
            none_completed = true
            if goal.remaining_amount < 0 then
              print("AAAAAAAAAAAAAA" .. goal.remaining_amount)
              div({ class = "card goal-card" }, function()
                div({ class = "card-top" }, function()
                  div(function()
                    h3({ class = "card-header" }, goal.name)
                    p({ class = "card-paragraph" }, goal.description)
                  end)
                  button(
                    {
                      class = "card-button",
                      ["hx-get"] = "/edit_goal/" .. goal.id,
                      ["hx-target"] =
                      ".new-goal-container"
                    },
                    "Redo goal")
                end)
                div({ class = "card-body" }, function()
                  div({
                    class = "duration",
                    function()
                      p({ class = "duration-header" }, "Duration")
                      p({ class = "duration-paragraph" }, goal.weeks_left)
                    end
                  })
                  div({ class = "amount" }, function()
                    p({ class = "amount-header" }, "Amount /w")
                    p({ class = "amount-paragraph" }, "₦ " .. goal.amount_per_week)
                  end)
                end)
                div({ class = "card-bottom" }, function()
                  div({ class = "progress" }, function()
                    h4({ class = "progress-bar-label" }, "Progress:")
                    progress({ value = goal.progress, max = goal.total_amount })
                    div({ class = "progress-details" }, function()
                      p({ class = "amount-remainig" }, function()
                        b("Remaining:")
                        br()
                        if goal.remaining_amount < 0 then
                          goal.remaining_amount = 0
                        end
                        text("₦ " .. goal.remaining_amount)
                      end)
                      p(function()
                        b(math.floor((goal.total_amount / goal.current_amount) * 10) .. "%")
                      end)
                      p({ class = "current-amount" }, function()
                        b("Current:")
                        br()
                        text("₦ " .. goal.current_amount)
                      end)
                    end)
                    button({
                      class = "delete-goal",
                      ["hx-get"] = "/delete_goal/" .. goal.id,
                      ["hx-confirm"] = "Are you sure you would like to delete this goal?",
                      ["hx-target"] = "body",
                      ["hx-swap"] = "outerHTML"
                    }, "Delete Goal")
                  end)
                end)
              end)
              none_completed = true
            else
              if none_completed == false then
                div({ class = "none-completed card" }, function()
                  h2("No completed Goals")
                end)
                none_completed = true
              end
            end
          end
        end)
      else
        div({ class = "first-row" }, function()
          div({ class = "header" }, function()
            h3("Ongoing")
            button({ ["hx-get"] = "/new_goal", ["hx-target"] = ".new-goal-container" }, "New goal +")
          end)
          div({ class = "horizontal-cards  ongoing" }, function()
            render("views.components.card_bills", { header = "Balance", paragraph = self.balance })
            div({ class = "none-completed card" }, function()
              h2("Create a new goal")
              button({ ["hx-get"] = "/new_goal", ["hx-target"] = ".new-goal-container" }, "New goal +")
            end)
          end)
        end)
        div({ class = "second-row" }, function()
          div({ class = "header" }, function()
            h3("Completed")
          end)
        end)
        div({ class = "horizontal-cards  ongoing" }, function()
          div({ class = "none-completed card" }, function()
            h2("No completed Goals")
          end)
        end)
      end
    end)
  end)
end)
