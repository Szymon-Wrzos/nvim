require("nvim-treesitter.configs").setup({
	ensure_installed = { "dockerfile" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "dockerls" },
	automatic_installation = true,
})

require("mason-null-ls").setup({
	ensure_installed = { "hadolint" },
	automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["dockerls"].setup({
	capabilities = capabilities,
})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.diagnostics.hadolint,
	},
})
