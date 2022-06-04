ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)





local base = Router.new()

local key = GetConvar("tebex_key", "")
local debug = true

if debug == true then
	if MySQL == nil then
		MySQL = {
			Async = {
				execute = function(query, params, cb)
					exports.ghmattimysql:execute(query, params, cb)
				end,
				fetchAll = function(query, params, cb)
					exports.ghmattimysql:execute(query, params, cb)
				end
			}
		}
	end
end

base:Post("/purchased", function(req, res)
	if debug == false then
		if key == "" then
			print("No key set")
			res:Send("", 400)
			return
		end
	end
	---@type PackagePurchase
	local data = req:Body()
	local hash = req:Header("X-BC-Sig")
	local genHash = exports.monetize:GenerateSHA256(key .. data.payment.txn_id .. data.payment.status .. data.customer.email)
	if debug == false then
		if hash ~= genHash then
			res:Send({}, 403)
			return
		end
	end

	if data.payment.status ~= "complete" then
		print("Payment status received for " .. data.customer.email .. " as [" .. data.payment.status .. "]")
		return
	end
	MySQL.Async.execute("INSERT INTO tebex_transactions(identifier, txn_id, tx_data, processed) VALUES(@identifier, @txn_id, @tx_data, @processed)", {
		["@identifier"] = "fivem:" .. data.customer.uuid,
		["@txn_id"] = data.payment.txn_id,
		["@tx_data"] = json.encode(data),
		["@processed"] = 0,
	}, function()
		Monetize:OnPurchase(req:Body())
	end)
	res:Send({}, 200)
end)

Server.use("", base)

Server.listen()

Monetize:AddPackage(Package.new(4304771, function(cb, source, package)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then return end
	xPlayer.addAccountMoney("bank", 50000000)
	--xPlayer.addInventoryItem("water", 10)
	TriggerClientEvent("esx:showNotification", xPlayer.source, "Thanks for your purchase!")
	cb()
end))

Monetize:AddPackage(Package.new(4304777, function(cb, source, package)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then return end
	xPlayer.addAccountMoney("bank", 100000000)
	--xPlayer.addInventoryItem("water", 10)
	TriggerClientEvent("esx:showNotification", xPlayer.source, "Thanks for your purchase!")
	cb()
end))

Monetize:AddPackage(Package.new(4304778, function(cb, source, package)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then return end
	xPlayer.addAccountMoney("bank", 150000000)
	--xPlayer.addInventoryItem("water", 10)
	TriggerClientEvent("esx:showNotification", xPlayer.source, "Thanks for your purchase!")
	cb()
end))

Monetize:AddPackage(Package.new(4852915, function(cb, source, package)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer == nil then return end
    xPlayer.addAccountMoney("bank", 200000000)
    --xPlayer.addInventoryItem("water", 10)
    TriggerClientEvent("esx:showNotification", xPlayer.source, "Thanks for your purchase!")
    cb()
end))

Monetize:AddPackage(Package.new(4304772, function(cb, source, package)
	local xPlayer = ESX.GetPlayerFromId(source)
	if type(package.package.variables) == "table" then
		for k,v in pairs(package.package.variables) do
			if v.identifier == "car_models" then
				local model = v.option
				TriggerClientEvent('discord:giveCar', source, model, source)
				TriggerClientEvent("esx:showNotification", xPlayer.source, "Thanks for your purchase!")
			end
		end
	end
	cb()
end))

---@param steamID string
---@param name string
---@param miles number
---@param cb fun(): void
function QueueMiles(steamID, name, miles, cb)
	local expires_at = os.time() + 2678400
	MySQL.Async.fetchAll("SELECT * FROM `queueprio` WHERE steam = @steam LIMIT 1", {
		["@steam"] = steamID
	}, function(rows)
		rows = rows or {}
		if #rows == 0 then
			MySQL.Async.execute("INSERT INTO queueprio(steam, miles, name, expires_at) VALUE(@steam, @miles, @name, @expires_at)", {
				["@steam"] = steamID,
				["@miles"] = miles,
				["@name"] = name,
				["@expires_at"] = expires_at
			}, function()
				cb()
			end)
		else
			MySQL.Async.execute("UPDATE queueprio SET expires_at = @expires_at WHERE steam = @steam", {
				["@expires_at"] = expires_at,
				["@steam"] = steam
			}, function()
				cb()
			end)
		end
	end)
end


Monetize:AddPackage(Package.new(4456310, function(cb, source, package)
	local miles = 600
	local steamID = Util.getSteam(source)
	if steamID == nil then
		print("^1[" .. GetCurrentResourceName() .. "]: failed to get steam ID for source " .. source .. "^7")
		return
	end

	QueueMiles(steamID, package.customer.ign, miles, function()
		TriggerEvent("roca:updatePoints", steamID, miles)
		cb()
	end)
end, true))


Monetize:AddPackage(Package.new(4684319, function(cb, source, package)
	local miles = 700
	local steamID = Util.getSteam(source)
	if steamID == nil then
		print("^1[" .. GetCurrentResourceName() .. "]: failed to get steam ID for source " .. source .. "^7")
		return
	end

	QueueMiles(steamID, package.customer.ign, miles, function()
		TriggerEvent("roca:updatePoints", steamID, miles)
		cb()
	end)
end, true))

Monetize:AddPackage(Package.new(0000, function(cb, source, package)
	local steamID = Util.getSteam(source)
	if steamID == nil then
		print("^1[" .. GetCurrentResourceName() .. "]: failed to get steam ID for source " .. source .. "^7")
		return
	end

	MySQL.Async.execute("INSERT INTO ped_users(steamID, created_at) VALUES(@steamid, @created_at)", {
		["@steamid"] = steamID,
		["@created_at"] = os.time()
	}, function()
		cb()
	end)
end, false))
