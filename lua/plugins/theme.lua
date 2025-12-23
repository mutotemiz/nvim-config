return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        -- options: "storm", "moon", "night", "day"
        style = "storm", 
        transparent = false, -- Set to true if your terminal has a background image/blur
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },
        -- Enable specific plugin integrations
        plugins = {
          all = true, -- Automatically handles nvim-tree, telescope, etc.
        },
      })

      -- Load the colorscheme
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },
}
