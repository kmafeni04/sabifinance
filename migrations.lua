local db = require("lapis.db")
local schema = require("lapis.db.schema")
local types = schema.types

return {
	[1] = function()
		schema.create_table("users", {
			{ "id",       types.serial },
			{ "username", types.text },
			{ "email",    types.text },
			{ "password", types.text },

			"PRIMARY KEY (id)"
		})
		db.insert("users", {
			username = "kmafeni04",
			email = "komemafeni944@gmail.com",
			password = "aPassword*"
		})
	end,
}
