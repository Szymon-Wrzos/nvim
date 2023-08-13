local luasnip = require("luasnip")

local react_component_snippet = require("snippets.javascript.react.react_component")
local react_context_snippet = require("snippets.javascript.react.react_context")
local use_state = require("snippets.javascript.react.use_state")

local react_snippets = {
	react_component_snippet,
	react_context_snippet,
	use_state,
}

local js_snippets = {}

for key, val in pairs(react_snippets) do
	js_snippets[key] = val
end

luasnip.add_snippets("typescriptreact", react_snippets)
luasnip.add_snippets("javascriptreact", react_snippets)
luasnip.add_snippets("javascript", js_snippets)
luasnip.add_snippets("typescript", js_snippets)

for _, file in
	ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/snippets/console_snippets", [[v:val =~ '\.lua$']]))
do
	local filename = file:gsub("%.lua$", "")
	local snippet = require("snippets.console_snippets." .. filename)
	luasnip.add_snippets(filename, { snippet })
end
