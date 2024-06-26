return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  keys = {
    { "<leader>e", desc = "Toggle NvimTree" },
  },
  config = function()
    vim.g.netrw_banner = 0
    vim.opt.termguicolors = true

    local tree_status_ok, tree = pcall(require, "nvim-tree")
    if not tree_status_ok then
      return
    end
    tree.setup({
      sort_by = "case_sensitive",
      actions = {
        open_file = { quit_on_open = false },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      filters = {
        custom = { "^.git$", "^node_modules$" },
      },
      git = {
        enable = false,
      },
      log = {
        enable = true,
        types = {
          diagnostics = true,
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        debounce_delay = 50,
        icons = {
          error = " ",
          warning = " ",
          hint = " ",
          info = " ",
        },
      },
    })
		local keymap = vim.keymap
		keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
  end,
}
