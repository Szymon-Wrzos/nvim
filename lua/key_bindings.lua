local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-r>", "<cmd>:RnvimrToggle<cr>", { desc = "[S]earch [R]esume" })

vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if require("luasnip").choice_active() then
		return "<Plug>luasnip-next-choice"
	else
		return "<Tab>"
	end
end, {
	expr = true,
})
