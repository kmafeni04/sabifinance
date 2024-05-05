return {
  analytics_chart = function()
    return { render = "components.analytics_chart" }
  end,
  home_content_dashboard = function(self)
    self.current = "dashboard"
    self.sub_heading = "Dashboard"
    self.sub_heading_desc = "Welcome, " .. tostring(self.session.username)
    return { render = "components.home_content" }
  end,
  home_content_goals = function(self)
    self.current = "goals"
    self.sub_heading = "Goals"
    self.sub_heading_desc = "Manage your goals"
    return { render = "components.home_content" }
  end,
  home_content_achievements = function(self)
    self.current = "achievements"
    self.sub_heading = "Achievments"
    self.sub_heading_desc = "View your achievements"
    return { render = "components.home_content" }
  end,
  home_content_tasks = function(self)
    self.current = "tasks"
    self.sub_heading = "Daily Tasks"
    self.sub_heading_desc = "Check on your tasks"
    return { render = "components.home_content" }
  end,
  home_content_settings = function(self)
    self.current = "settings"
    self.sub_heading = "Settings"
    self.sub_heading_desc = "Manage your user preferences"
    return { render = "components.home_content" }
  end
}
