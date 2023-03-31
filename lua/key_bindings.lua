local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ca", "<cmd>:CodeActionMenu<cr>", { desc = "[C]ode [A]ction" })

vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if require("luasnip").choice_active() then
		return "<Plug>luasnip-next-choice"
	else
		return "<Tab>"
	end
end, {
	expr = true,
})
