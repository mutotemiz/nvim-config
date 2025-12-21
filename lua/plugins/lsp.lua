return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "basedpyright", "ruff" },
      })

      local caps = require("cmp_nvim_lsp").default_capabilities()
      
      -- We switch to UTF-16 because BasedPyright is hardcoded for it.
      -- This makes Ruff and BasedPyright agree, which clears the warning.
      caps.offsetEncoding = { "utf-16" }
      caps.general = { positionEncodings = { "utf-16" } }

      -- 1. Configure BasedPyright
      vim.lsp.config("basedpyright", {
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
        capabilities = caps,
        settings = {
          python = {
            pythonPath = vim.g.python3_host_prog,
          },
        },
      })

      -- 2. Configure Ruff
      vim.lsp.config("ruff", {
        cmd = { "ruff", "server" },
        filetypes = { "python" },
        capabilities = caps,
        -- Disable diagnostics from Ruff so only BasedPyright shows errors
        on_attach = function(client)
          client.server_capabilities.diagnosticProvider = false
        end,
      })

      -- 3. Enable the servers
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("ruff")
    end,
  },
}
