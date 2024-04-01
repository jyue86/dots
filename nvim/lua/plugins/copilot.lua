return {
	"zbirenbaum/copilot.lua",
	cmd = { "Copilot auth", "Copilot" },
	config = function()
		require("copilot").setup({
			cmd = "Copilot",
			event = "InsertEnter",
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<C-J>",
				},
			},
			filetypes = {
				svelte = true,
				typescript = true,
				python = true,
				cpp = true,
			},
		})

		vim.keymap.set("n", "<space>c", require("copilot.panel").open, { silent = true, script = true })
	end,
}
