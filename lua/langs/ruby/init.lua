local M = {}

M.treesitter = { "ruby" }

M.lspconfig = {
	{ lsp = "solargraph" },
}

M.mason = {
}

M.mason.lspconfig = {
	"solargraph",
}

M.mason.null_ls = {
	"rubocop",
}

M.null_ls = {
	formatting = { { program = "rubocop" } },
	diagnostics = { { program = "rubocop" } },
}
return M
