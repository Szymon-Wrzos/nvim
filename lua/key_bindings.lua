local opts = { noremap = true, silent = true }

vim.keymap.set({ "n" }, "<leader>ha", vim.lsp.buf.hover, { desc = "Trigger [h]over [a]ction" })
