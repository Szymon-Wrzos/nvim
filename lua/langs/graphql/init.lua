local M = {}

M.treesitter = {
	"graphql",
}

M.lspconfig = {
	{ lsp = "graphql" },
}

M.mason.lspconfig = {
	"graphql",
}

M.mason.null_ls = {
	"prettierd",
}

M.null_ls = {
	formatter = { { program = "prettierd", with = { filetypes = { "graphql", "gql" } } } },
}
return M
