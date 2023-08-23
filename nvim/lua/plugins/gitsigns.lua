return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	config = function()
		local gitsigns_status_ok, gitsigns = pcall(require, "gitsigns")
		if not gitsigns_status_ok then
			return
		end

		gitsigns.setup()
	end,
}
