require("mason-lspconfig").setup({
	ensure_installed = { "tailwindcss" },
})

require("mason-null-ls").setup({
	ensure_installed = { "rustywind" },
})

require("lspconfig")["tailwindcss"].setup({})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.formatting.rustywind,
	},
})
