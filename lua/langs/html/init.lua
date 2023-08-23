local M = {}

M.treesitter = {
	"html",
}

M.lspconfig = {
	{ lsp = "html" },
}

M.mason = {}

M.mason.lspconfig = {
	"html",
}

M.mason.null_ls = {
	"curlylint",
	"prettierd",
}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "html" } } } },
	diagnostics = { { program = "curlylint" } },
}
return M
