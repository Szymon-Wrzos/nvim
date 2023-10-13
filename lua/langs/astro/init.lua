local M = {}

M.treesitter = {
	"astro",
}

M.lspconfig = {
	{ lsp = "astro" },
}

M.mason = {}

M.mason.lspconfig = {
	"astro",
}

M.mason.null_ls = {}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "astro" } } } },
	diagnostics = { { program = "eslint_d", with = { filetypes = { "astro" } } } },
}
return M
