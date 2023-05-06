require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "typescript", "tsx", "jsdoc" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "tsserver" },
	automatic_installation = true,
})

require("mason-null-ls").setup({
	ensure_installed = { "eslint_d" },
	automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["tsserver"].setup({
	capabilities = capabilities,
})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.code_actions.eslint_d,
	},
	debug = true,
})
