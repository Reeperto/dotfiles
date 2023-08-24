	local base_command = "yabai -m config "

---Sets config entries for Yabai
---@param config table
YabaiConfig = function (config)
	for k, v in pairs(config) do
		if type(v) == "boolean" then
				if v == false then
					os.execute(base_command..k.." off")
				else
					os.execute(base_command..k.." on")
				end
			return;
		else
			os.execute(base_command..k.." "..tostring(v))
		end
	end
end
