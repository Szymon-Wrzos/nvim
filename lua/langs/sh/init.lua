local M = {}

M.treesitter = {
	"bash",
}

M.lspconfig = {
	{ lsp = "bashls" },
}

M.mason = {}

M.mason.lspconfig = {
	"bashls",
}

M.mason.null_ls = {
	"beautysh",
	"shellcheck",
}

M.null_ls = {
	formatter = { { program = "beautysh" } },
	diagnostics = { { program = "shellcheck" } },
	code_actions = { { program = "shellcheck" } },
	rest = {},
}
return M
