local M = {}

M.init = function()
	require("onenord").setup({
		theme = "dark",
	})
end

M.config = {
	"rmehri01/onenord.nvim",
	priority = 1000,
	lazy = false,
	config = M.init,
}

return M
