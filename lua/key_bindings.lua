local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ca", "<cmd>:CodeActionMenu<cr>", { desc = "[C]ode [A]ction" })

vim.keymap.set("n", "<leader>rr", "<cmd>:NvimTreeToggle<cr>", { desc = "Nvim T[r]ee Toggle" })

vim.keymap.set("n", "<leader>ng", "<cmd>:LazyGit<cr>", { desc = "Lazy[g]it" })

vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if require("luasnip").choice_active() then
		return "<Plug>luasnip-next-choice"
	else
		return "<Tab>"
	end
end, {
	expr = true,
})

vim.keymap.set({ "n" }, "<leader>ha", vim.lsp.buf.hover, { desc = "Trigger [h]over [a]ction" })
