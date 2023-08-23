local M = {}

M.treesitter = { "vue" }

M.lspconfig = {
	{ lsp = "volar" },
}

M.mason = {}

M.mason.lspconfig = {
	"volar",
}

M.mason.null_ls = {
	"eslint_d",
	"prettierd",
}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "vue" } } } },
}
return M
