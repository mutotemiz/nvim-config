return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- 1. Use Zathura
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_view_zathura_check_libsynctex = 1

      -- 2. Ensure VimTeX uses neovim-remote
      vim.g.vimtex_compiler_progname = 'nvr'
      
      -- 3. Clean up the interface
      vim.g.vimtex_quickfix_mode = 0 
      
      -- 4. Compiler settings
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
    end,

	-- Closing pdf viewer automatically after the master document is closed.
    config = function()
      local zathura_grp = vim.api.nvim_create_augroup("ZathuraCleanup", { clear = true })

      -- Use the VimTeX specific event instead of the global VimLeave
      vim.api.nvim_create_autocmd("User", {
        group = zathura_grp,
        pattern = "VimtexEventQuit",
        callback = function()
          -- This only runs when the specific LaTeX session ends
          pcall(os.execute, "pkill -f zathura")
        end,
      })
    end,
  }
}
