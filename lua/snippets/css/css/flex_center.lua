local luasnip = require("luasnip")
local i = luasnip.insert_node
local c = luasnip.choice_node
local sn = luasnip.snippet
local fmt = require("luasnip.extras.fmt").fmt
local t = luasnip.t

local format = [[
    {selector} {{
      display: flex;
      flex-flow: {direction} {wrap};
      justify-content: center;
      align-items: center;
    }}
]]

local flex_center = sn(
	{ trig = "fler", dscr = "Centering using flexbox" },
	fmt(format, {
		selector = i(1, "Insert selector"),
		direction = c(2, { t("row"), t("column"), t("row-reverse"), t("column-reverse") }),
		wrap = c(3, { t("wrap"), t("wrap-reverse"), t("nowrap") }),
	})
)

return flex_center
