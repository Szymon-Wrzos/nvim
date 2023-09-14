local M = {}

M.config = {
	"kdheepak/lazygit.nvim",

	keys = { {
		"<leader>lg",
		"<cmd>:LazyGit<cr>",
		desc = "[L]azy[g]it",
	} },
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
return M
