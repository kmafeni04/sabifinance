local Model = require("lapis.db.model").Model
local db = require("lapis.db")
local Users, Users_mt = Model:extend("users")

function Users_mt:create_user(username, email, password)
  Users:create({
    username = username,
    email = email,
    password = password
  })
end

function Users_mt:get_user_info(username)
  local user_info = Users:find(db.clause({
    username = username
  }))
  return user_info
end

return Users
