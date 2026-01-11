return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "kdheepak/cmp-latex-symbols",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.set_config({
  	-- This is the key: it stops snippets from overstaying their welcome
  	region_check_events = "InsertEnter",
  	delete_check_events = "InsertLeave",
      })
      
      local lspkind = require("lspkind")

      _G.has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
            :sub(col, col)
            :match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        --------------------------------------------------------------------
        -- MERGED FORMATTING BLOCK (this is the part you asked for)
        --------------------------------------------------------------------
        formatting = {
		  fields = { "kind", "abbr", "menu" },
		  format = function(entry, vim_item)
			-- Fix latex_symbols inserting BOTH \alpha and α
			if entry.source.name == "latex_symbols" then
			  local label = entry.completion_item.label
			  
			  -- Use a Lua pattern to grab only the LaTeX command (the part starting with \)
			  -- This removes the trailing space and unicode symbol
			  local clean_label = label:match("(\\%a+)")
			  
			  if clean_label then
				vim_item.abbr = clean_label -- Clean the display name
				entry.completion_item.insertText = clean_label -- Clean the actual insertion
				
				if entry.completion_item.textEdit then
				  entry.completion_item.textEdit.newText = clean_label
				end
			  end
			end

			return lspkind.cmp_format({
			  mode = "symbol",
			  maxwidth = 50,
			  ellipsis_char = "...",
			  show_labelDetails = true,
			  before = function(entry, vim_item)
				vim_item.menu = ({
				  nvim_lsp      = "[LSP]",
				  luasnip       = "[Snippet]",
				  buffer        = "[Buffer]",
				  latex_symbols = "[Latex]",
				})[entry.source.name]
				return vim_item
			  end,
			})(entry, vim_item)
		  end,
		},

        --------------------------------------------------------------------

        mapping = cmp.mapping.preset.insert({
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

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),

          ["<C-e>"] = cmp.mapping.abort(),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          {
            name = "latex_symbols",
            option = {
              strategy = 0,
              insert_as_unicode = false,
            }
          },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}

