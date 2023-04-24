local function dump(o)
	if type(o) == "table" then
		local ss = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			ss = ss .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return ss .. "} "
	else
		return tostring(o)
	end
end

return dump
