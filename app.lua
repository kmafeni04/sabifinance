local lapis = require("lapis")
local app = lapis.Application()

local generic_controller = require("controllers.generic_controller")
local user_controller = require("controllers.user_controller")
local home_controller = require("controllers.home_controller")
local transaction_controller = require("controllers.transaction_controller")
local goal_controller = require("controllers.goal_controller")
local component_controller = require("controllers.component_controller")
local task_controller = require("controllers.task_controller")
local achievement_controller = require("controllers.achievement_controller")

app:enable("etlua")
app.layout = require "views.layout"

--- routes ---

--- index ---

app:get("index", "/", generic_controller.index)

--- login ---

app:get("login", "/login", user_controller.login)

app:get("/login_page", user_controller.login_page)

--- signup ---

app:get("signup", "/signup", user_controller.signup)

app:get("/signup_page", user_controller.signup_page)

app:post("signup_complete", "/signup_complete", user_controller.signup_complete)

--- home ---

app:get("home", "/home/:page", home_controller.home)

app:post("/logout", user_controller.logout)

--- settings ---

app:get("settings", "/home/settings", home_controller.settings)

app:post("settings", "/home/settings", home_controller.settings_post)

app:delete("/delete_account", user_controller.delete_account)

--- dashboard ---

app:get("dashboard", "/home/dashboard", home_controller.dashboard)

app:post("dashboard", "/home/dashboard", home_controller.home_post)

app:get("/new_transaction", transaction_controller.new_transaction)

app:post("/new_transaction", transaction_controller.new_transaction_post)

app:get("/delete_transaction/:id", transaction_controller.delete_transaction)

--- tasks ---

app:get("tasks", "/home/tasks", task_controller.tasks_page)

-------------

--- achievements ---

app:get("achievements", "/home/achievements", achievement_controller.achievements_page)

--- goals ---

app:get("goals", "/home/goals", goal_controller.goal_page)

app:get("/new_goal", goal_controller.new_goal)

app:post("/goal_created", goal_controller.goal_created)


app:get("/delete_goal/:id", goal_controller.delete_goal)

app:get("/edit_goal/:id", goal_controller.edit_goal)


--- components ---

app:get("/analytics_chart", component_controller.analytics_chart)

return app
