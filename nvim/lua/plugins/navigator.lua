return {
	"numToStr/Navigator.nvim",
	keys = {
		{ "<a-h>", "<cmd>NavigatorLeft<cr>", desc = "NavigatorLeft" },
		{ "<a-j>", "<cmd>NavigatorDown<cr>", desc = "NavigatorRight" },
		{ "<a-k>", "<cmd>NavigatorUp<cr>", desc = "NavigatorUp" },
		{ "<a-l>", "<cmd>NavigatorRight<cr>", desc = "NavigatorDown" },
		{ "<a-\\>", "<cmd>NavigatorPrevious<cr>", desc = "NavigatorPrevious" },
	},
	config = function()
		require("Navigator").setup()
	end,
}
