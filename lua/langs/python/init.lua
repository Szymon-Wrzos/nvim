require("nvim-treesitter.configs").setup({
	ensure_installed = { "python" },
	auto_install = true,
})

require("mason-lspconfig").setup({
	ensure_installed = { "pyright" },
})

require("mason-null-ls").setup({
	ensure_installed = { "ruff" },
})

local format = require("lsp-format")
format.setup({})

require("lspconfig")["pyright"].setup({
	on_attach = format.on_attach,
})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.formatting.ruff,
		null_ls.builtins.diagnostics.ruff,
	},
})
