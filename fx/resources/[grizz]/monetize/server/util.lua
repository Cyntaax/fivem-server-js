Util = {}
--- Gets the fivem identifier for the player
---@param source number
function Util.getFiveM(source)
	local identifiers = GetPlayerIdentifiers(source)

	for _, identifier in pairs(identifiers) do
		if string.find(identifier, "fivem:") then
			return identifier
		end
	end
end

--- Gets the steam identifier for the player
---@param source number
function Util.getSteam(source)
	local identifiers = GetPlayerIdentifiers(source)

	for _, identifier in pairs(identifiers) do
		if string.find(identifier, "steam:") then
			return identifier
		end
	end
	return "steam:update-me"
end
