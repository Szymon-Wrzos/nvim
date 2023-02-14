require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "typescript" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "tsserver" },
})

require("mason-null-ls").setup({
	ensure_installed = { "eslint_d", "prettierd" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["tsserver"].setup({
	capabilities = capabilities,
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.completion.luasnip,
	},
	debug = false,
	on_attach = require("lsp-format").on_attach,
})
