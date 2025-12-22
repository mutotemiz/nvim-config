return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      local telescope = require('telescope')
      
      telescope.setup({
        defaults = {
          path_display = { "smart" }, -- Shows shorter paths
          mappings = {
            i = {
              ["<C-k>"] = require('telescope.actions').move_selection_previous, -- move to prev result
              ["<C-j>"] = require('telescope.actions').move_selection_next,     -- move to next result
            },
          },
        },
      })

      -- Load the fzf extension for speed
      telescope.load_extension('fzf')
    end
  }
}
