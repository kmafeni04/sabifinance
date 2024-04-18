local db = require("lapis.db")
local schema = require("lapis.db.schema")
local types = schema.types

return {
	[1] = function()
		schema.create_table("users", {
			{ "id",       types.serial },
			{ "username", types.varchar },
			{ "email",    types.varchar },
			{ "password", types.varchar },

			"PRIMARY KEY (id)"
		})
		db.insert("users", {
			username = "kmafeni04",
			email = "komemafeni944@gmail.com",
			password = "aPassword*"
		})
	end,
	[2] = function()
		schema.create_table("transactions", {
			{ "id",          types.serial },
			{ "date",        types.date },
			{ "name",        types.varchar },
			{ "amount",      types.double },
			{ "type",        types.varchar },
			{ "description", types.text },
			{ "user_id",     types.foreign_key },

			"FOREIGN KEY (user_id) REFERENCES users(id)",
			"PRIMARY KEY (id)"
		})

		schema.create_table("goals", {
			{ "id",          types.serial },
			{ "name",        types.varchar },
			{ "description", types.text },
			{ "end_date",    types.date },
			{ "amount",      types.double },
			{ "user_id",     types.foreign_key },

			"FOREIGN KEY (user_id) REFERENCES users(id)",
			"PRIMARY KEY (id)"
		})
	end,
}
