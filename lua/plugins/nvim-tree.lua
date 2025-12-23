return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        -- IMPROVEMENT: Optimize filesystem watching
        filesystem_watchers = {
          enable = true,
          debounce_delay = 50,
          ignore_dirs = { "node_modules", ".git", "__pycache__", ".venv", "env" },
        },
        view = {
          width = 30,
          relativenumber = true,
        },
        renderer = {
          group_empty = true,
          -- IMPROVEMENT: Disable "highlight_opened_files" to save resources
          highlight_opened_files = "none",
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          -- IMPROVEMENT: Filter out heavy directories from the view entirely
          custom = { "__pycache__", ".git", "node_modules", ".venv", "env" },
        },
        -- IMPROVEMENT: Be less aggressive with Git checking
        git = {
          enable = true,
          ignore = true, -- ignore files that are git-ignored to save scan time
          timeout = 400, -- kill the git process if it takes too long
        },
      })
    end,
  },
}
