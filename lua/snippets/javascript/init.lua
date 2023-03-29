local luasnip = require("luasnip")

local react_component_snippet = require("snippets.javascript.react.react_component")

local react_snippets = {
	react_component_snippet,
}

luasnip.add_snippets("typescriptreact", react_snippets)
luasnip.add_snippets("javascriptreact", react_snippets)
luasnip.add_snippets("javascript", react_snippets)
