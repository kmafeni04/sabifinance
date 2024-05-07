local Achievements = require("models.achievements")
return {
  achievements_page = function(self)
    Achievements:create_achievements(self.session.username)
    self.achievements = Achievements:select()
    return { render = "pages.home.achievements.achievements_page", layout = "home_layout" }
  end,
}
