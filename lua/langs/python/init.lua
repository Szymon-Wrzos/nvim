require("nvim-treesitter.configs").setup({
	ensure_installed = { "python" },
	auto_install = true,
})

require("mason-lspconfig").setup({
	ensure_installed = { "ruff_lsp" },
})

require("mason-null-ls").setup({
	ensure_installed = { "ruff" },
})

local format = require("lsp-format")
format.setup({})

require("lspconfig")["pyright"].setup({})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.ruff,
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.completion.luasnip,
	},
	debug = false,
	on_attach = require("lsp-format").on_attach,
})
