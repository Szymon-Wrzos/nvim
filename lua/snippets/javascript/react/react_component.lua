local luasnip = require("luasnip")
local sn = luasnip.snippet
local i = luasnip.insert_node
local c = luasnip.choice_node
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local react_boilerplate = sn(
	"FunComBoi",
	fmt(
		[[
import React from 'react';
import PropTypes from 'prop-types';

/**
  * @typedef {{Object}} props 
  *
  */
/** 
  * @param {{props}} props
  */ 
const {name} = ({{}}) => {{
  {}/* Your function goes here*/
}};
{name}.propTypes = {{}}

{export_method}
]],
		{
			name = i(1, "Component"),
			export_method = d(2, function(args)
				local component_name = args[1][1]
				return s(nil, {
					c(1, {
						i(1, "export default " .. component_name .. ";"),
						i(2, "export { " .. component_name .. " };"),
					}),
				})
			end, { 1 }),
			i(0),
		},
		{
			repeat_duplicates = true,
		}
	)
)

return react_boilerplate
