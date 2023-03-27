require("nvim-treesitter.configs").setup({
	ensure_installed = { "python" },
	auto_install = true,
})

require("mason-lspconfig").setup({
	ensure_installed = { "pyright" },
})

require("mason-null-ls").setup({
	ensure_installed = { "black" },
})

require("lspconfig")["pyright"].setup({})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.formatting.black,
	},
})
