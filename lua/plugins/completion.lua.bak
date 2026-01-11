return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        
        -- FIXED: Optimized formatting to prevent double icons
        formatting = {
          fields = { "kind", "abbr", "menu" }, -- Forces order: [Icon] [Name] [Source]
          format = lspkind.cmp_format({
            mode = 'symbol', -- Only show icon in the 'kind' column
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function(entry, vim_item)
              -- This ensures the "menu" (source name) looks clean
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip  = "[Snippet]",
                buffer   = "[Buffer]",
              })[entry.source.name]
              return vim_item
            end
          })
        },

        mapping = cmp.mapping.preset.insert({
          -- TAB: Go Down / Next Snippet Placeholder
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif _G.has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- SHIFT-TAB: Go Up / Previous Snippet Placeholder
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.abort(),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
