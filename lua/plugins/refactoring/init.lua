local M = {}

M.init = function()
	require("refactoring").setup()
end

M.config = {
	"ThePrimeagen/refactoring.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = M.init,
}

return M
