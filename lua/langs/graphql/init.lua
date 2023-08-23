local M = {}

M.treesitter = {
	"graphql",
}

M.lspconfig = {
	{ lsp = "graphql" },
}

M.mason = {}

M.mason.lspconfig = {
	"graphql",
}

M.mason.null_ls = {
	"prettierd",
}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "graphql", "gql" } } } },
}
return M
