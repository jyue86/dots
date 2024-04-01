return {
	"numToStr/Navigator.nvim",
	keys = {
		{ "<c-h>", "<cmd>NavigatorLeft<cr>", desc = "NavigatorLeft" },
		{ "<c-j>", "<cmd>NavigatorDown<cr>", desc = "NavigatorRight" },
		{ "<c-k>", "<cmd>NavigatorUp<cr>", desc = "NavigatorUp" },
		{ "<c-l>", "<cmd>NavigatorRight<cr>", desc = "NavigatorDown" },
		{ "<c-\\>", "<cmd>NavigatorPrevious<cr>", desc = "NavigatorPrevious" },
	},
	config = function()
		require("Navigator").setup()
	end,
}
