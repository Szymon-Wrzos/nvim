local opts = { noremap = true, silent = true }

vim.keymap.set({ "n" }, "<leader>ha", vim.lsp.buf.hover, { desc = "Trigger [h]over [a]ction" })
vim.keymap.set({ "n" }, "<leader>,", vim.lsp.buf.format, { desc = "Trigger [L]SP formatting" })
