---@class Package
---@field ID number The tebex ID of the package
---@field onPurchase fun(cb: fun(), source: number, purchasePacket: PackagePacket): void The purchase handler
---@field RunOnConnect boolean Whether this should run on connection. Default `false`
Package = setmetatable({}, Package)

Package.__call = function()
	return "Package"
end

Package.__index = Package

---@param id number The package ID as presented on tebex
---@param onPurchase fun(cb: fun(), source: number, purchasePacket: PackagePacket): void the callback handler to run when the package is purchased
---@param runOnConnect boolean Whether this should run on connection. Default `false`
function Package.new(id, onPurchase, runOnConnect)
	local _Package = {
		ID = id,
		onPurchase = onPurchase or function()
		end,
		RunOnConnect = runOnConnect or false
	}

	return setmetatable(_Package, Package)
end

---@param data PackagePacket
---@param cb fun(val: boolean): void
---@param isOnConnect boolean
function Package:Execute(data, cb, isOnConnect, source)
	if type(cb) ~= "function" then
		cb = function()
			print("Placeholder callback")
		end
	end

	local targetSource = source or 0

	--for i=0, playerIndices, 1 do
	for _, player in ipairs(GetPlayers()) do
		if player ~= nil then
			player = tonumber(player)
			local identifiers = GetPlayerIdentifiers(player)

			for _, identifier in pairs(identifiers) do
				if "fivem:" .. data.customer.uuid == identifier then
					targetSource = player
				end
			end
		end
	end

	if targetSource == 0 and isOnConnect ~= true then
		print("^3[monetize]^7: Player " .. data.customer.ign .. " appears to be offline...")
		cb(false)
	else
		local tasks = {}
		local retVal = nil
		for i = 1, data.package.purchase_data.quantity, 1 do
			table.insert(tasks, function(callbackOuter)
				self.onPurchase(function(ret)
					print("^3[monetize]^7: Processed " .. data.package.name .. " for " .. data.customer.ign)
					if ret == false then
						retVal = false
					end
					callbackOuter()
				end, targetSource, data)
			end)
		end

		Async.series(tasks, function()
			cb(retVal)
		end)
	end
end
