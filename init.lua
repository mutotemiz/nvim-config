-- ============================================================================
-- Basic settings
-- ============================================================================

vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- ============================================================================
-- Python provider configuration
-- ============================================================================

vim.g.python3_host_prog = vim.fn.expand(
  "~/.local/share/nvim/venv/neovim/bin/python"
)

-- Optional: disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
