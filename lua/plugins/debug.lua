return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -------------------------------------------------------------------------
      -- 1. Visual Customization (Gutter Icons)
      -------------------------------------------------------------------------
      vim.fn.sign_define('DapBreakpoint', { text='󰏃', texthl='DapBreakpoint', linehl='', numhl='' })
      vim.fn.sign_define('DapBreakpointCondition', { text='󰟃', texthl='DapBreakpointCondition', linehl='', numhl='' })
      vim.fn.sign_define('DapLogPoint', { text='󰬚', texthl='DapLogPoint', linehl='', numhl='' })
      vim.fn.sign_define('DapStopped', { text='󰁕', texthl='DapStopped', linehl='DebugHighlight', numhl='' })

      -------------------------------------------------------------------------
      -- 2. Automation: Open/Close UI
      -------------------------------------------------------------------------
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -------------------------------------------------------------------------
      -- 3. Python Specific Config (Dynamic Path)
      -------------------------------------------------------------------------
      -- This finds your Mason data directory automatically
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(mason_path)
    end,
  },
}
