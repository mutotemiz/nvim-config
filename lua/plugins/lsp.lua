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
        -- texlab added for openSUSE LaTeX support
        ensure_installed = { "basedpyright", "ruff", "texlab" },
      })
      
      -- 2. General Tool auto-install (Debuggers, Formatters, etc.)
      require("mason-tool-installer").setup({
        ensure_installed = {
          "debugpy", 
          "tree-sitter-cli", -- Useful for parsing errors we fixed earlier
        },
      })

      local caps = require("cmp_nvim_lsp").default_capabilities()
      
      -- UTF-16 encoding to keep BasedPyright and Ruff in sync
      caps.offsetEncoding = { "utf-16" }
      caps.general = { positionEncodings = { "utf-16" } }

      -- 1. Configure BasedPyright (Python)
      vim.lsp.config("basedpyright", {
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
        capabilities = caps,
        settings = {
          basedpyright = {
            analysis = {
              -- Disabling the strict diagnostic rules to simplify the errpr and warnings
              diagnosticSeverityOverrides = {
                reportImplicitRelativeImport = "none",
                reportUnknownArgumentType = "none",
                reportUnknownMemberType = "none",
                reportUnknownVariableType = "none",
              },
              pythonPath = vim.g.python3_host_prog,
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      -- 2. Configure Ruff (Python Linter)
      vim.lsp.config("ruff", {
        cmd = { "ruff", "server" },
        filetypes = { "python" },
        capabilities = caps,
        -- Disable diagnostics from Ruff so they don't double-up with Pyright
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
              onSave = true, -- Auto-build PDF on save
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
