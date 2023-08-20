require("lazy").install({
	"roobert/tailwindcss-colorizer-cmp.nvim",
})

require("mason-lspconfig").setup({
	ensure_installed = { "tailwindcss" },
	automatic_installation = true,
})

require("mason-null-ls").setup({
	ensure_installed = { "rustywind" },
	automatic_installation = true,
})

require("lspconfig")["tailwindcss"].setup({})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.formatting.rustywind,
	},
})
