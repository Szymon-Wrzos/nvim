local M = {}

M.treesitter = {}

M.lspconfig = {
	{ lsp = "prosemd_lsp" },
}

M.mason = {}

M.mason.lspconfig = {
	"prosemd_lsp",
}

M.mason.null_ls = {
	"typos",
}

M.null_ls = {
	diagnostics = { { program = "typos", with = { filetypes = { "markdown", "yaml", "json", "html" } } } },
}
return M
