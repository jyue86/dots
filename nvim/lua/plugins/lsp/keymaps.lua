local M = {}

M._keys = nil

function M.get()
  -- local format = require("plugins.lsp.format").format
  if not M._keys then
    M._keys = {
      { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "<leader>cl", "<cmd>LspInfo<cr>",        desc = "Lsp Info" },
      -- {
      --   "gd",
      --   "<cmd>Telescope lsp_definitions<cr>",
      --   desc = "Goto Definition",
      --   has = "definition",
      -- },
      {
        "gd",
        vim.lsp.buf.definition,
        desc = "Goto Definition",
        has = "definition",
      },
      -- { "gr", "<cmd>Telescope lsp_references<cr>",       desc = "References" },
      -- { "gr", vim.lsp.buf.references, desc = "References" },
      { "gr", require("telescope.builtin").lsp_references, "References w/ Telescope" },
      { "gD", vim.lsp.buf.declaration,                     desc = "Goto Declaration" },
      -- { "gI", "<cmd>Telescope lsp_implementations<cr>",  desc = "Goto Implementation" },
      -- { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
      { "K",  vim.lsp.buf.hover,                           desc = "Hover" },
      {
        "gK",
        vim.lsp.buf.signature_help,
        desc = "Signature Help",
        has = "signatureHelp",
      },
      {
        "<c-s>",
        vim.lsp.buf.signature_help,
        mode = "i",
        desc = "Signature Help",
        has = "signatureHelp",
      },
      { "]d", M.diagnostic_goto(true),           desc = "Next Diagnostic" },
      { "[d", M.diagnostic_goto(false),          desc = "Prev Diagnostic" },
      { "]e", M.diagnostic_goto(true, "ERROR"),  desc = "Next Error" },
      { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
      { "]w", M.diagnostic_goto(true, "WARN"),   desc = "Next Warning" },
      { "[w", M.diagnostic_goto(false, "WARN"),  desc = "Prev Warning" },
      -- k "<leader>cf", format,                            desc = "Format Document", has = "documentFormatting" },
      -- {
      --   "<leader>cf",
      --   format,
      --   desc = "Format Range",
      --   mode = "v",
      --   has = "documentRangeFormatting",
      -- },
      {
        "<leader>ca",
        vim.lsp.buf.code_action,
        desc = "Code Action",
        mode = { "n", "v" },
        has = "codeAction",
      },
      {
        "<leader>cA",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end,
        desc = "Source Action",
        has = "codeAction",
      },
    }
    M._keys[#M._keys + 1] = { "<space>rn", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
  end
  return M._keys
end

function M.on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}

  for _, value in ipairs(M.get()) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set("n", keys[1], keys[2], opts)
    end
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return M
