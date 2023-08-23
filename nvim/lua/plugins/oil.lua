return {
  "stevearc/oil.nvim",
  opts = {},
  cmd = { "Oil" },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil_status_ok, oil = pcall(require, "oil")
    if not oil_status_ok then
      return
    end

    oil.setup()
  end,
}
