require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "typescript" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "tsserver" },
})

require("mason-null-ls").setup({
	ensure_installed = { "eslint_d", "prettierd" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local format = require("lsp-format")
format.setup({})

require("lspconfig")["tsserver"].setup({
	capabilities = capabilities,
	on_attach = format.on_attach,
})


local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.code_actions.eslint_d,
	},
  debug= true,
})
