local db = require("lapis.db")
local schema = require("lapis.db.schema")
local types = schema.types
local create_table = schema.create_table
local create_index = schema.create_index

return {
	[1] = function()
		create_table("users", {
			{ "id",       types.integer },
			{ "username", types.text },
			{ "email",    types.text },
			{ "password", types.text },

			"PRIMARY KEY (id)"
		})

		create_index("users", "username", { unique = true })
		create_index("users", "email", { unique = true })

		db.insert("users", {
			id = "1",
			username = "kmafeni04",
			email = "komemafeni944@gmail.com",
			password = "aPassword*"
		})
	end,
	[2] = function()
		create_table("transactions", {
			{ "id",          types.integer },
			{ "date",        types.text },
			{ "name",        types.text },
			{ "amount",      types.real },
			{ "type",        types.text },
			{ "description", types.text },
			{ "user_id",     types.integer },

			"FOREIGN KEY (user_id) REFERENCES users(id)",
			"PRIMARY KEY (id)"
		})

		create_table("goals", {
			{ "id",          types.integer },
			{ "name",        types.text },
			{ "description", types.text },
			{ "end_date",    types.text },
			{ "amount",      types.real },
			{ "user_id",     types.integer },

			"FOREIGN KEY (user_id) REFERENCES users(id)",
			"PRIMARY KEY (id)"
		})
	end,
}
