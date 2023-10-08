local M = {}

M.treesitter = {
	"astro",
}

M.lspconfig = {
	{ lsp = "astro" },
}

M.mason = {}

M.mason.lspconfig = {
	"astro-language-server",
}

M.mason.null_ls = {}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "astro" } } } },
}
return M