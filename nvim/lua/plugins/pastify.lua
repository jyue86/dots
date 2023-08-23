return {
	"TobinPalmer/pastify.nvim",
	cmd = { "Pastify" },
	config = function()
		require("pastify").setup({
			opts = {
				apikey = "0f0a0ba2b10b26c6b939d8886a19dbca",
			},
		})
	end,
}
