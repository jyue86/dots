local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  config = function(_)
    local null_ls_status_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_status_ok then
      return
    end

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint.with({
          filetypes = {
            "svelte",
            "typescript",
          },
        }),
        null_ls.builtins.formatting.prettierd.with({
          command = "prettierd",
          filetypes = {
            "json",
            "svelte",
            "typescript",
          },
        }),
        null_ls.builtins.formatting.clang_format.with({
          filetypes = {
            "cpp",
            "hpp",
          },
        }),
        null_ls.builtins.formatting.cmake_format.with({
          filetypes = {
            ".txt",
          },
        }),
        -- null_ls.builtins.formatting.ruff,
        -- null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.xmlformat.with({
          filetypes = {
            ".xml",
            ".sdf",
          },
        }),
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
