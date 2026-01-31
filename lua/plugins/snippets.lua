return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      -- Load snippets from friendly-snippets (includes LaTeX, Python, etc.)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  }
}
