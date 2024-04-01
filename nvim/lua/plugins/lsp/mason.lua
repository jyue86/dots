return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "lua-language-server",
        "clangd",
        "clang-format",
        "codelldb",
        "basedpyright",
        -- "ruff-lsp",
        -- "ruff",
        "black",
        "debugpy",
        "rust-analyzer",
        "svelte-language-server",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local registry = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = registry.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      --[[ if type(registry.refresh) == "function" then
        registry.refresh()
      else
        ensure_installed()
      end ]]
      ensure_installed()
    end,
  },
}
