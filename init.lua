require("plugins_entry")

require("key_bindings")
require("opts")

-- Plugins setup
require("plugins.treesitter.init")

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
