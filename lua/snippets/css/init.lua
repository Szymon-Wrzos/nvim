local luasnip = require("luasnip")
local flex_center = require("snippets.css.css.flex_center")

local tailwind_like_media_queries = require("snippets.css.css.tailwind_like_queries")
local css = {
	flex_center,
}

for _, value in ipairs(tailwind_like_media_queries) do
	table.insert(css, value)
end

luasnip.add_snippets("css", css)
