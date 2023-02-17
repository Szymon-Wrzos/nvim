 require ("nvim-treesitter.configs").setup({
	ensure_installed = { "html" },
	auto_install = true,
})

 require ("mason-lspconfig").setup({
	ensure_installed = { "html" },
})

 require ("mason-null-ls").setup({
	ensure_installed = { "" },
})
