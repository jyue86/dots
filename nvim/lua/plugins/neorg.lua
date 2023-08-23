return {
	"nvim-neorg/neorg",
	cmd = { "Neorg" },
	build = ":Neorg sync-parsers",
	opts = {
		load = {
			["core.defaults"] = {}, -- Loads default behaviour
			["core.concealer"] = {}, -- Adds pretty icons to your documents,
			["core.dirman"] = { -- Manages Neorg workspaces
				config = {
					workspaces = {
						stickyboard = "~/stickyboard",
						as2guard = "~/Documents/AS2Guard/notes",
					},
					default_workspace = "stickyboard",
					autochdir = true,
				},
			},
			["core.export"] = { config = { extensions = "all" } },
			["core.export.markdown"] = { config = { extensions = "all" } },
			["core.summary"] = {},
		},
	},
	dependencies = { { "nvim-lua/plenary.nvim" } },
}
