local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-r>", "<cmd>:RnvimrToggle<cr>", { desc = "[S]earch [R]esume" })
