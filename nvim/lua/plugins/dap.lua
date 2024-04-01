return {
  {
    "mfussenegger/nvim-dap",
    event="VeryLazy",
    config = function()
		  local map = vim.keymap
		  local dap = require("dap")

      function Restart()
        dap.disconnect()
        dap.close()
        dap.continue()
      end

      map.set("n", "<F2>", dap.disconnect)
      map.set("n", "<F3>", dap.step_over)
      map.set("n", "<F4>", dap.step_into)
      map.set("n", "<F5>", dap.step_out)
      -- map.set("n", "<F8>", "<cmd>lua require'dap'.disconnect(); require'dap'.close(); require'dap'.continue()<cr>")
      map.set("n", "<F8>", Restart)
      map.set("n", "<F9>", dap.continue)
      map.set("n", "<leader>db", dap.toggle_breakpoint)
      map.set(
			"n",
			"<leader>dbc<cr>",
			"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>"
		)
		map.set(
			"n",
			"<leader>lp<cr>",
			"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>"
		)
		map.set("n", "<leader>dr<cr>", "<cmd>lua require'dap'.repl.open()<cr>")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event="VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    event="VeryLazy",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "python3"
      require("dap-python").setup(path)
      -- require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "nvim-neotest/nvim-nio",
    event="VeryLazy",
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event="VeryLazy",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },
}
