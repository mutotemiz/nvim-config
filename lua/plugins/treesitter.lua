return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Modern approach for v1.0+: call setup on the main module
      require("nvim-treesitter").setup({
        -- This list tells nvim-treesitter what to install/keep updated
        ensure_installed = { "python", "lua", "vim", "vimdoc", "query", "markdown", "latex", "bibtex" },
        auto_install = true,
        
        highlight = {
          enable = true,
          -- Since you have BasedPyright, we disable regex highlighting
          additional_vim_regex_highlighting = false, 
        },
        
        indent = { enable = true },
      })
    end,
  },
}
