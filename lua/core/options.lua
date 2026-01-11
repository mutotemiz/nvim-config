vim.opt.timeoutlen = 300 -- Set to 300ms for snappier response
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 5
vim.opt.signcolumn = "yes"

-- Add this to the end of lua/core/options.lua
vim.opt.guicursor = "n-v-c:block-CursorNormal,i-ci-ve:ver25-CursorInsert,r-cr:hor20-CursorVisual"

-- Ensure the highlight groups are created AFTER the colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "CursorNormal", { fg = "#24283b", bg = "#7aa2f7" })
    vim.api.nvim_set_hl(0, "CursorInsert", { fg = "#24283b", bg = "#ff9e64" })
    vim.api.nvim_set_hl(0, "CursorVisual", { fg = "#24283b", bg = "#bb9af7" })
  end,
})


