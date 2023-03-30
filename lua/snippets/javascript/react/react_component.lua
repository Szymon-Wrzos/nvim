local luasnip = require("luasnip")
local sn = luasnip.snippet
local i = luasnip.insert_node
local c = luasnip.choice_node
local t = luasnip.t
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local react_boilerplate = sn(
	"FunComBoi",
	fmt(
		[[
import React from 'react';
import PropTypes from 'prop-types';

const {name} = () => {{
   /* Your function goes here*/
}};
{prop_types}

{export_method}
]],
		{
			-- i(1) is at nodes[1], i(2) at nodes[2].
			name = i(1, "Component"),
			prop_types = d(2, function(args)
				local component_name = args[1][1]
				return s(nil, {
					t(component_name .. ".propTypes = {};"),
				})
			end, { 1 }),
			export_method = d(3, function(args)
				local component_name = args[1][1]
				return s(nil, {
					c(1, {
						i(1, "export default " .. component_name .. ";"),
						i(2, "export { " .. component_name .. " };"),
					}),
				})
			end, { 1 }),
		}
	)
)

return react_boilerplate
