return {
	"kiyoon/jupynium.nvim",
	cmd = {
		"JupyniumStartAndAttachToServer",
	},
	config = function()
		vim.keymap.set("n", "<space>x", "<cmd>JupyniumExecuteSelectedCells<cr>")
	end,
}
