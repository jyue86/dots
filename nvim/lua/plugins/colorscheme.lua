return {
	"bluz71/vim-nightfly-colors",
	name = "nightfly",
	lazy = false,
	priority = 1000,
	config = function(_)
		vim.g.nightflyVirtualTextColor = true
		vim.cmd([[colorscheme nightfly]])
	end,
}
