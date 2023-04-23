local luasnip = require("luasnip")

local tailwind_like_media_queries = require("snippets.css.css.tailwind_like_queries")

local css = {}

for _, value in ipairs(tailwind_like_media_queries) do
	table.insert(css, value)
end

luasnip.add_snippets("css", css)
