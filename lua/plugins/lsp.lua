return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      
      -- 1. LSP specific auto-install
      require("mason-lspconfig").setup({
        ensure_installed = { "basedpyright", "ruff", "texlab" },
      })
      
      -- 2. General Tool auto-install (Debuggers, Formatters, etc.)
      require("mason-tool-installer").setup({
        ensure_installed = {
          "debugpy", 
        },
      })

      local caps = require("cmp_nvim_lsp").default_capabilities()
      
      -- We switch to UTF-16 because BasedPyright is hardcoded for it.
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
      
      -- 3. Configure Texlab (LaTeX)
      vim.lsp.config("texlab", {
        cmd = { "texlab" },
        filetypes = { "tex", "bib" },
        capabilities = caps,
        settings = {
          texlab = {
            build = {
              onSave = true, -- Automatically build PDF on save
            },
            diagnostics = {
              delay = 300,
            }
          }
        }
      })

      -- 4. Enable the servers
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("ruff")
      vim.lsp.enable("texlab")
    end,
  },
}
