return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]], -- Ctrl + \ toggles the terminal
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = 'horizontal', -- You can also use 'vertical', 'float', or 'tab'
        close_on_exit = true,
      })

      -- Special keymaps for the terminal mode
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        -- Allow Esc to exit terminal mode (normally you'd need Ctrl-\ Ctrl-n)
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        -- Easy navigation out of terminal
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      -- Apply these mappings every time a terminal opens
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
  }
}
