return {
  index = function(self)
    if self.session.logged_in == true then
      return { redirect_to = self:url_for("dashboard") }
    end
    return { render = "pages.index" }
  end,
}
