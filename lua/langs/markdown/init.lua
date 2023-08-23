local M = {}

M.treesitter = { "markdown" }

M.lspconfig = {
	{ lsp = "marksman" },
}

M.mason = {}

M.mason.lspconfig = {
	"marksman",
}

M.mason.null_ls = {
	"markdownlint",
}

M.null_ls = {
	formatter = { { program = "markdownlint" } },
	diagnostics = { { program = "markdownlint" } },
}
return M
