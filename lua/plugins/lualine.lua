return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- 1. Define the Tokyonight Storm Palette
      local colors = {
        blue   = "#7aa2f7", -- Normal Mode Cursor
        orange = "#ff9e64", -- Insert Mode Cursor
        purple = "#bb9af7", -- Visual Mode Cursor
        bg     = "#24283b", -- Storm Background
        fg     = "#c0caf5", -- Default text
      }

      -- 2. Create a custom theme that overrides ONLY the mode (section 'a')
      local custom_tokyonight = require('lualine.themes.tokyonight-storm')
      
      -- Match Lualine section 'a' to your cursor colors
      custom_tokyonight.normal.a = { bg = colors.blue, fg = colors.bg, gui = 'bold' }
      custom_tokyonight.insert.a = { bg = colors.orange, fg = colors.bg, gui = 'bold' }
      custom_tokyonight.visual.a = { bg = colors.purple, fg = colors.bg, gui = 'bold' }
      custom_tokyonight.replace.a = { bg = colors.purple, fg = colors.bg, gui = 'bold' }

      -- Helper: Get active LSP names
      local function get_lsp_client_names()
        local msg = 'No LSP'
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if next(clients) == nil then return msg end
        local client_names = {}
        for _, client in ipairs(clients) do
          table.insert(client_names, client.name)
        end
        return table.concat(client_names, ', ')
      end

      -- Helper: Get Python Virtual Env name
      local function get_venv()
        if vim.bo.filetype ~= 'python' then return "" end
        local venv = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_DEFAULT_ENV')
        if venv then
          return " " .. venv:match("([^/]+)$")
        end
        return ""
      end

      -- 3. Setup Lualine with the custom theme
      require('lualine').setup({
        options = {
          theme = custom_tokyonight, -- Use our modified theme
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          globalstatus = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {{ 'filename', path = 1 }},
          lualine_x = {
            { get_venv, color = { fg = colors.orange } },
            { get_lsp_client_names, icon = ' ', color = { fg = colors.fg, gui = 'bold' } },
            'encoding', 
            'filetype'
          },
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end
  }
}
