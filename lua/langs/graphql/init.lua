require("nvim-treesitter.configs").setup({
	ensure_installed = { "graphql" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "graphql" },
	automatic_installation = true,
})

require("mason-null-ls").setup({
	ensure_installed = { "prettierd" },
	automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["graphql"].setup({
	capabilities = capabilities,
	filetypes = { "gql", "graphql", "javascript", "typescript" },
})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.formatting.prettierd.with({ filetypes = { "gql", "graphql" } }),
	},
	debug = true,
})
