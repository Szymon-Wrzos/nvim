local M = {}

M.init = function()
	require("mini.cursorword").setup()
end

M.config = {
	"echasnovski/mini.cursorword",
	event = "InsertEnter",
	config = M.init,
}

return M
