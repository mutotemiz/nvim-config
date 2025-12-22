-- ~ / .config / nvim / lua / core / keymaps.lua

local keymap = vim.keymap

-- Set leader key to Space
vim.g.mapleader = " "

-------------------------------------------------------------------------------
-- 1. LSP UI & Diagnostic Configuration
-------------------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = false, -- Keeps the line clean; use 'gl' or '<leader>dl' to see errors
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focused = false,
    style = "minimal",
    border = "rounded", -- Nice rounded borders for popups
    source = "always",  -- Shows if error is from BasedPyright or Ruff
    header = "",
    prefix = "",
  },
})

-------------------------------------------------------------------------------
-- 2. LSP Mappings (Leader + l for "LSP/Language")
-------------------------------------------------------------------------------
keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { desc = "LSP: [L]ook at [D]efinition" })
keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { desc = "LSP: [L]ook at [H]over (Docs)" })
keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = "LSP: [L]anguage [R]ename" })
keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = "LSP: [L]anguage [A]ctions" })
keymap.set('n', '<leader>lu', vim.lsp.buf.references, { desc = "LSP: [L]ist [U]sages" })
keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, { desc = "LSP: [L]ook at [S]ignature" })

-------------------------------------------------------------------------------
-- 3. Diagnostic Mappings (Leader + d for "Diagnostics/Errors")
-------------------------------------------------------------------------------
-- Shared 'gl' mapping for quick access to line errors
keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Diag: Show [L]ine error" })

keymap.set('n', '<leader>dl', vim.diagnostic.open_float, { desc = "Diag: [D]isplay [L]ine Error" })
keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = "Diag: [D]iagnostic [N]ext" })
keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = "Diag: [D]iagnostic [P]rev" })

-------------------------------------------------------------------------------
-- 4. Buffer Management (Leader + b for "Buffer")
-------------------------------------------------------------------------------
keymap.set('n', '<leader>bk', ':bd<CR>', { desc = "[B]uffer [K]ill" })
keymap.set('n', '<leader>bn', ':bn<CR>', { desc = "[B]uffer [N]ext" })
keymap.set('n', '<leader>bp', ':bp<CR>', { desc = "[B]uffer [P]revious" })

-------------------------------------------------------------------------------
-- 5. Global Helpers (Used by nvim-cmp for Tab navigation)
-------------------------------------------------------------------------------
_G.has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-------------------------------------------------------------------------------
-- 6. Automation: Auto-format on Save
-------------------------------------------------------------------------------
-- This uses Ruff (or any active LSP) to clean your code every time you save.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    -- 1. Organize Imports (Removes unused ones)
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
    -- 2. Wait a tiny bit for the first action to finish, then format
    vim.defer_fn(function()
      vim.lsp.buf.format({ async = false })
    end, 100)
  end,
})

-------------------------------------------------------------------------------
-- 7. File Explorer Mapping
-------------------------------------------------------------------------------
keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Explorer: [E]xplorer Toggle" })
keymap.set('n', '<leader>ef', ':NvimTreeFindFile<CR>', { desc = "Explorer: [E]xplorer [F]ind Current File" })

return {}
