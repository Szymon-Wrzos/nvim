local M = {}

M.init = function()
	require("refactoring").setup()
end

M.config = {
	"ThePrimeagen/refactoring.nvim",
	cmd = "Refactor",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = M.init,
}

return M
