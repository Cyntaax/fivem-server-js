RegisterServerEvent('monetize:sv:init')
AddEventHandler('monetize:sv:init', function()
	local source = source
	local fivem = Util.getFiveM(source)
	if fivem ~= nil then
		MySQL.Async.fetchAll("SELECT * FROM tebex_transactions WHERE identifier = @identifier AND processed = 0", {
			["@identifier"] = fivem,
		}, function(results)
			results = results or {}
			for k, v in pairs(results) do
				local parsedData = json.decode(v.tx_data)
				Monetize:OnPurchase(parsedData)
			end
		end)
	else
		-- no identifier was found
	end
end)


--12/22
AddEventHandler("playerConnecting", function(name, _kick, _deferral)
	local source = source
	local fivem = Util.getFiveM(source)
	if fivem ~= nil then
		MySQL.Async.fetchAll("SELECT * FROM tebex_transactions WHERE identifier = @identifier AND processed = 0", {
			["@identifier"] = fivem
		}, function(results)
			results = results or {}
			for k, v in pairs(results) do
				local parsedData = json.decode(v.tx_data)
				Monetize:OnPurchase(parsedData, true, source)
			end
		end)
	end
end)
