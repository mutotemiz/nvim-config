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
-- Prepend Mason to PATH so Neovim finds the servers
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- Set your Python provider (your specific venv)
vim.g.python3_host_prog = vim.fn.expand("$HOME/.local/share/nvim/venv/neovim/bin/python3")

-- Disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

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

-- Load core configurations
require("core.keymaps")
require("core.options")


require("lazy").setup({
  spec = {
    { import = "plugins" }, -- This tells Lazy to look in lua/plugins/
  },
})
