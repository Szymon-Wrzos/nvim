local M = {}

M.init = function()
	require("nvim_comment").setup({})
end

M.config = {
	"terrortylor/nvim-comment",
	event = "BufNew",
	config = M.init,
}

return M
