local Achievements = require("models.achievements")
return {
  achievements_page = function(self)
    Achievements:create_achievements()
    return { render = "pages.home.achievements.achievements_page" }
  end,
}
