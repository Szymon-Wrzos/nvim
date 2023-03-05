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

local format = require("lsp-format")
format.setup({})

require("lspconfig")["html"].setup({
	capabilities = capabilities,
	on_attach = format.on_attach,

})


local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.diagnostics.curlylint,
	},
})
