local M = {}

M.treesitter = { "vue" }

M.lspconfig = {
	{ lsp = "volar" },
}

M.mason.lspconfig = {
	"volar",
}

M.mason.null_ls = {
	"eslint_d",
	"prettierd",
}

M.null_ls = {
	formatter = { { program = "prettierd", with = { filetypes = { "vue" } } } },
}
return M
