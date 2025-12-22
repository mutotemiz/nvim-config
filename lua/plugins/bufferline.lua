return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- show open buffers
          separator_style = "slant", -- options: "slant" | "slope" | "thick" | "thin"
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            }
          },
          show_buffer_close_icons = true,
          show_close_icon = false,
        }
      })
    end
  }
}
