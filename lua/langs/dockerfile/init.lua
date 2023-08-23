local M = {}

M.treesitter = {
	"dockerfile",
}

M.lspconfig = {
	{ lsp = "dockerls" },
}

M.mason = {}

M.mason.lspconfig = {
	"dockerls",
}

M.mason.null_ls = {
	"hadolint",
}

M.null_ls = {
	diagnostics = { { program = "hadolint" } },
}
return M
