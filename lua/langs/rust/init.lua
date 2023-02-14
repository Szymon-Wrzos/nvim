require("nvim-treesitter.configs").setup({
	ensure_installed = { "rust" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "rust_analyzer" },
})
require("mason-null-ls").setup({
	ensure_installed = { "rustfmt" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").rust_analyzer.setup({
	capabilities = capabilities,
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.rustfmt,
	},
	debug = false,
	on_attach = require("lsp-format").on_attach,
})
