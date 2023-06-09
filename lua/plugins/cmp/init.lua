local luasnip = require("luasnip")
local cmp = require("cmp")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lspkind = require("lspkind")

cmp.setup({
	performance = {
		max_view_entries = 20,
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "text_symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				return vim_item
			end,
			menu = {
				nvim_lsp = "[LSP]",
				luasnip = "[Luasnip]",
				path = "[Path]",
				buffer = "[Buffer]",
				["cmp-tw2css"] = "[TW2CSS]",
				codeium = "[Codeium]",
			},
		}),
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "cmp-tw2css" },
		{
			name = "nvim_lsp",

			entry_filter = function(entry)
				return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
			end,
		},
		{
			name = "nvim_lua",
		},
		{ name = "path" },
		{ name = "buffer" },
		{ name = "codeium" },
	}),

	mapping = cmp.mapping.preset.insert({
		["<C-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-b>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<Enter>"] = cmp.mapping.confirm({ select = true }),
		["<C-Esc>"] = cmp.mapping(function(fallback)
			luasnip.unlink_current()
			fallback()
		end),
		["<C-t>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-q>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
})
