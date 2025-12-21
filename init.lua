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

-- ============================================================================
-- lazy.nvim bootstrap 
-- ============================================================================
-- ============================================================================
-- lazy.nvim bootstrap (self-installing)
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.notify("Installing lazy.nvim...", vim.log.levels.INFO)

  local cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }

  local result = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to install lazy.nvim:\n" .. result, vim.log.levels.ERROR)
    return
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install = { missing = true },
  checker = { enabled = false },
})

