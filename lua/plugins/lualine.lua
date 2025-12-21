return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Helper: Get active LSP names for the current buffer
      local function get_lsp_client_names()
        local msg = 'No LSP'
        local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
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
          -- Get just the folder name (e.g., ".venv" or "my-env")
          return " " .. venv:match("([^/]+)$")
        end
        return ""
      end

      require('lualine').setup({
        options = {
          theme = 'auto', -- Automatically matches your colorscheme
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          globalstatus = true, -- Single statusline for all windows
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {
            { 'filename', path = 1 } -- 1 = relative path
          },
          lualine_x = {
            { get_venv, color = { fg = '#ff9e64' } }, -- Python Env in Orange
            { get_lsp_client_names, icon = ' ', color = { fg = '#ffffff', gui = 'bold' } },
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
