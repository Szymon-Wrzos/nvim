require("nvim-treesitter.configs").setup({
	ensure_installed = { "json" },
	auto_install = true,
})

require("mason-lspconfig").setup({
	ensure_installed = { "jsonls" },
})

require("mason-null-ls").setup({
	ensure_installed = { "jsonlint", "prettierd" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["jsonls"].setup({
	capabilities = capabilities,
})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.diagnostics.jsonlint,
	},
	debug = true,
})
