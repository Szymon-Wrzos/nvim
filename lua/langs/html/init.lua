require("nvim-treesitter.configs").setup({
	ensure_installed = { "html" },
	auto_install = true,
})

require("mason-lspconfig").setup({
	ensure_installed = { "html" },
})

require("mason-null-ls").setup({
	ensure_installed = { "curlylint" },
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.curlylint,
	},
	debug = false,
	on_attach = require("lsp-format").on_attach,
})
