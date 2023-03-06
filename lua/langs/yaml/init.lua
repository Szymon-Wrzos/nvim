require("nvim-treesitter.configs").setup({
	ensure_installed = { "yaml" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "yamlls" },
})

require("mason-null-ls").setup({
	ensure_installed = { "yamllint", "prettierd" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["yamlls"].setup({
	capabilities = capabilities,
})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.diagnostics.yamllint,
	},
	debug = true,
})
