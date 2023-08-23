local M = {}

M.treesitter = { "python" }

M.lspconfig = {
	{ lsp = "pyright" },
}

M.mason = {}

M.mason.lspconfig = {
	"pyright",
}

M.mason.null_ls = {
	"black",
	"ruff",
}

M.null_ls = {
	formatting = { { program = "black" }, { program = "ruff" } },
	diagnostics = { { program = "ruff" } },
}
return M
