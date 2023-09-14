local M = {}

M.config = {
	"weilbith/nvim-code-action-menu",
	cmd = "CodeActionMenu",
	keys = { {
		"<leader>ca",
		"<cmd>:CodeActionMenu<cr>",
		desc = "[C]ode [A]ction",
	} },
}

return M
