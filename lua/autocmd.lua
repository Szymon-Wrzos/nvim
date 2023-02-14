local api = vim.api


api.nvim_create_autocmd("BufWritePost", {command = "Prettier"})
