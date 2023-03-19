local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end
local map = vim.api.nvim_set_keymap

map("n", "<C-l>", "<cmd>:BufferLineCycleNext<cr>", { desc = "Next Tab" })
map("n", "<C-k>", "<cmd>:BufferLineCyclePrev<cr>", { desc = "Previous Tab" })
map("n", "<leader>l", "<cmd>:BufferLineCloseRight<cr>", { desc = "Close tabs to the right" })
map("n", "<leader>k", "<cmd>:BufferLineCloseLeft<cr>", { desc = "Close tabs to the left" })

bufferline.setup({})
