require("plugins_entry")

require("key_bindings")
require("opts")

require("mason").setup({})
-- Plugins setup
require("plugins.treesitter.init")
require("plugins.cmp.init")
require("plugins.telescope.init")
require("plugins.gitsigns.init")
require("plugins.lualine.init")
require("plugins.bufferline.init")
require("plugins.trouble.init")
require("plugins.nvim_tree.init")
require("plugins.codeium.init")
require("plugins.wilder.init")
require("plugins.which_key.init")
-- Languages setup
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.completion.luasnip,
	},
	on_attach = require("lsp-format").on_attach,
})

require("langs.lua.init")
require("langs.rust.init")
require("langs.javascript.init")
require("langs.css.init")
require("langs.html.init")
require("langs.tailwindcss.init")
require("langs.python.init")
require("langs.json.init")
require("langs.yaml.init")
require("langs.markdown.init")
require("langs.graphql.init")
require("langs.vue.init")
require("langs.sh.init")
require("langs.dockerfile.init")

-- Snippets
require("snippets.javascript.init")
require("snippets.css.init")

require("plugins.colorscheme.init")

require("mini.cursorword").setup()

require("nvim-web-devicons").setup({})
require("nvim-ts-autotag").setup()

require("nvim_comment").setup({})

require("leap").add_default_mappings()
