local luasnip = require("luasnip")

local astro_boilterplate = require("snippets.astro.template_boilerplate")

local astro_snippets = {
	astro_boilterplate,
}

luasnip.add_snippets("typescriptreact", astro_snippets)
