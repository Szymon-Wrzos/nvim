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

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["html"].setup({
	capabilities = capabilities,
})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.diagnostics.curlylint,
		null_ls.builtins.formatting.prettierd.with({ filetypes = { "html" } }),
	},
})
