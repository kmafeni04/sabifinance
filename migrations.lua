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
			{ "id",               types.integer },
			{ "name",             types.text },
			{ "description",      types.text },
			{ "end_date",         types.text },
			{ "date_created",     types.integer },
			{ "amount_per_week",  types.real },
			{ "current_amount",   types.real },
			{ "remaining_amount", types.real },
			{ "total_amount",     types.real },
			{ "weeks_left",       types.integer },
			{ "progress",         types.integer },
			{ "user_id",          types.integer },

			"FOREIGN KEY (user_id) REFERENCES users(id)",
			"PRIMARY KEY (id)"
		})
	end,
	[3] = function()
		create_table("tasks", {
			{ "id",          types.integer },
			{ "name",        types.text },
			{ "description", types.text },
			{ "progress",    types.integer },
			{ "total",       types.integer },
			{ "user_id",     types.integer },

			"FOREIGN KEY (user_id) REFERENCES users(id)",
			"PRIMARY KEY (id)"
		})
		create_table("achievements", {
			{ "id",          types.integer },
			{ "name",        types.text },
			{ "description", types.text },
			{ "progress",    types.integer },
			{ "total",       types.integer },
			{ "user_id",     types.integer },

			"FOREIGN KEY (user_id) REFERENCES users(id)",
			"PRIMARY KEY (id)"
		})
	end
}
