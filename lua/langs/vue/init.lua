require("nvim-treesitter.configs").setup({
	ensure_installed = { "vue" },
	auto_install = true,
})

require("mason-lspconfig").setup({
	ensure_installed = { "volar" },
	automatic_installation = true,
})

require("mason-null-ls").setup({
	ensure_installed = { "eslint_d" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()


require("lspconfig")["volar"].setup({
	capabilities = capabilities,
	filetypes = {"vue" },
})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.eslint_d,
	},
})
