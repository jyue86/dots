return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  main = "ibl",
  opts = {},
  config = function ()
    require("ibl").setup()
  end
}
