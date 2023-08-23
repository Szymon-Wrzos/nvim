local M = {}

M.treesitter = { "rust" }

M.lspconfig = {
	{ lsp = "rust_analyzer" },
}

M.mason = {}

M.mason.lspconfig = {
	"rust_analyzer",
}

M.mason.null_ls = {
	"rustfmt",
}

M.null_ls = {
	formatter = { { program = "rustfmt" } },
}
return M
