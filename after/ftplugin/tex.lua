-- Settings just for LaTeX
vim.opt_local.spell = true      -- Enable spellcheck
vim.opt_local.shiftwidth = 2    -- 2 spaces for LaTeX indents
vim.opt_local.wrap = true       -- Enable soft wrap

-- The folding logic
vim.g.vimtex_fold_enabled = 1
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "vimtex#fold#level(v:lnum)"

-- Navigation for wrapped lines (Normal Mode)
vim.keymap.set('n', 'j', 'gj', { buffer = true, silent = true })
vim.keymap.set('n', 'k', 'gk', { buffer = true, silent = true })
vim.keymap.set('n', '<Down>', 'gj', { buffer = true, silent = true })
vim.keymap.set('n', '<Up>', 'gk', { buffer = true, silent = true })

-- Navigation for wrapped lines (Insert Mode)
vim.keymap.set('i', '<Down>', '<C-o>gj', { buffer = true, silent = true })
vim.keymap.set('i', '<Up>', '<C-o>gk', { buffer = true, silent = true })

-- Navigation for Visual Mode
vim.keymap.set('v', 'j', 'gj', { buffer = true, silent = true })
vim.keymap.set('v', 'k', 'gk', { buffer = true, silent = true })

-- Folding titles
function CustomTexFold()
    local fs = vim.v.foldstart
    local line = vim.fn.getline(fs)
    
    -- 1. Try to find Beamer frame title: \begin{frame}{Title}
    local title = line:match("\\begin{frame}.*{(.*)}")
    
    -- 2. If not a frame, try to find section title: \section{Title}
    if not title then
        title = line:match("\\section{(.*)}")
    end
    
    -- 3. If still nothing, just use the raw line but trim whitespace
    if not title or title == "" then
        title = line:gsub("^%s*", "")
    end

    -- 4. Get the number of lines folded
    local column_width = vim.api.nvim_win_get_width(0)
    local line_count = vim.v.foldend - vim.v.foldstart + 1
    local count_str = "(" .. line_count .. " lines) "
    
    -- 5. Construct the final string (No more dots!)
    return "  󰡍  " .. title .. " " .. count_str
end

-- Apply the function
vim.opt_local.foldtext = "v:lua.CustomTexFold()"

-- This line REMOVES the dots and the "0"
vim.opt_local.fillchars:append({ fold = " " })
