local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ca", "<cmd>:CodeActionMenu<cr>", { desc = "[C]ode [A]ction" })

vim.keymap.set({ "n" }, "<leader>ha", vim.lsp.buf.hover, { desc = "Trigger [h]over [a]ction" })
