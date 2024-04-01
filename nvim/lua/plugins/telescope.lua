return {
	"nvim-telescope/telescope.nvim",
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
	},
	keys = {
		-- { "<leader>f<cr>", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Search for files" },
		-- { "<leader>g<cr>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Live grep in codebase" },
		{ "<leader>f", function() require("telescope.builtin").find_files() end, desc = "Search for files" },
		{ "<leader>g<cr>", function() require("telescope.builtin").live_grep() end, desc = "Live grep in codebase" },
	},
	config = function(_, opts)
		local telescope_status_ok, telescope = pcall(require, "telescope")
		if not telescope_status_ok then
			return
		end
		telescope.setup(opts)

		local actions = require("telescope.actions")
		require("nvim-web-devicons").setup({
			override = {},
			default = true,
		})

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<c-u>"] = actions.preview_scrolling_up,
						["<c-d>"] = actions.preview_scrolling_down,
						["<c-p>"] = require("telescope.actions.layout").toggle_preview,
						["<c-j>"] = actions.move_selection_next,
						["<c-k>"] = actions.move_selection_previous,
						["<esc"] = actions.close,
						["<s-j>"] = actions.cycle_history_next,
						["<s-k>"] = actions.cycle_history_prev,
					},
				},
			},
			layout_config = {
				horizontal = {
					preview_cutoff = 100,
					preview_width = 0.6,
				},
			},
			preview = {
				hide_on_startup = false,
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})
		telescope.load_extension("fzf")
	end,
}
