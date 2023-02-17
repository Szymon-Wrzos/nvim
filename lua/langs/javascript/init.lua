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
	ensure_installed = { "eslint_d", "prettierd", "prettier" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local format = require("lsp-format")
format.setup({})

local prettierd = {
	formatCommand = [[prettierd ${INPUT}]],
	formatStdin = true,
}

require("lspconfig")["tsserver"].setup({
	capabilities = capabilities,
	on_attach = format.on_attach,
	settings = {
		languages = {
			typescript = { prettierd },
			javascript = { prettierd },
			javascriptreact = { prettierd },
			typescriptreact = { prettierd },
		},
	},
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.completion.luasnip,
	},
	debug = false,
	on_attach = require("lsp-format").on_attach,
})
