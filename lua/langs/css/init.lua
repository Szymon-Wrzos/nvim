require("nvim-treesitter.configs").setup({
	ensure_installed = { "css" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "cssls", "cssmodules_ls" },
})

require("mason-null-ls").setup({
	ensure_installed = { "stylelint" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["cssls"].setup({
	capabilities = capabilities,
})

require("lspconfig")["cssmodules_ls"].setup({
	capabilities = capabilities,
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.completion.luasnip,
	},
	debug = false,
	on_attach = require("lsp-format").on_attach,
})
