local Widget = require("lapis.html").Widget
local db = require("lapis.db")
local Model = require("lapis.db.model").Model
local Users = Model:extend("users")
-- local Transactions = Model:extend("transactions")
-- local Goals = Model:extend("goals")

return Widget:extend(function(self)
  div({ class = "goals" }, function()
    link({ rel = "stylesheet", href = "/static/CSS/goals.css" })
    div({ class = "top" }, function()
      h2("Goals")
      h4("View all your set goals")
    end)
    div({ class = "bottom" }, function()
      div({ class = "header" }, function()
        h3("Ongoing")
        button({ ["hx-get"] = "/new_goal", ["hx-target"] = ".new-goal-container" }, "New goal +")
      end)
      div({ class = "new-goal-container" })
      div({ class = "first-row" }, function()
        render("views.components.card_bills", { header = "Balance", paragraph = self.balance })
        div({ class = "horizontal-cards cards" }, function()
          local user = Users:find(db.clause({
            username = self.session.username
          }))
          div({ class = "card goal-card" }, function()
            div({ class = "card-top" }, function()
              div(function()
                h3({ class = "card-header" })
                p({ class = "card-paragraph" })
              end)
              button(
                {
                  class = "card-button",
                  ["hx-get"] = "/edit_goal/",
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
                  p({ class = "duration-paragraph" }, function()
                  end)
                end
              })
              div({ class = "amount" }, function()
                p({ class = "amount-header" }, "Amount /w")
                p({ class = "amount-paragraph" }, "₦ ")
              end)
            end)
            div({ class = "card-bottom" }, function()
              div({ class = "progress" }, function()
                h4({ class = "progress-bar-label" }, "Progress:")
                progress({ value = current_progress, max = goal_max })
                div({ class = "progress-details" }, function()
                  p({ class = "amount-remainig" }, function()
                    b("Remaining:")
                    br()
                    text("₦ ")
                  end)
                  p(b())
                  p({ class = "current-amount" }, function()
                    b("Current:")
                    br()
                    text("₦ ")
                  end)
                end)
              end)
              button({
                class = "delete-goal",
                ["hx-get"] = "/delete_goal/",
                ["hx-confirm"] = "Are you sure you would like to delete this goal?",
                ["hx-target"] = "body",
                ["hx-swap"] = "outerHTML"
              }, "Delete Goal")
            end)
          end)
          div({ class = "card no-goals-created" }, function()
            h2("Create a new goal")
            button({ ["hx-get"] = "/new_goal", ["hx-target"] = ".new-goal-container" }, "New goal +")
          end)
        end)
      end)
      div({ class = "second-row" }, function()
        div({ class = "header" }, function()
          h3("Completed")
        end)
        div({ class = "horizontal-cards cards" }, function()
          div({ class = "card" }, function()
            h3("No completed goals")
          end)
        end)
      end)
    end)
  end)
end)
