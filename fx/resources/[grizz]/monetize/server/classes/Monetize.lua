Monetize = {
	---@type Package[]
	Packages = {}
}

---@param id number
---@return Package
function Monetize:GetPackage(id)
	for k, v in pairs(self.Packages) do
		if v.ID == id then
			return v
		end
	end
end

--- Adds a package to the monetize container. Expects `package` to be an instance of
--- Package class
---@param package Package
---@return void
function Monetize:AddPackage(package)
	if package() ~= "Package" then
		return
	end
	local replaced = false
	for k, v in pairs(self.Packages) do
		if v.ID == package.ID then
			self.Packages[k] = package
			replaced = true
			break
		end
	end

	if replaced == false then
		table.insert(self.Packages, package)
	end
end

---@param data PackagePurchase
---@param isOnConnect boolean whether this onPurchase event is coming from a connect handler
---@param source number the custom source being sent on a connect event
function Monetize:OnPurchase(data, isOnConnect, source)
	if type(data.packages) == "table" then
		local given = false
		local packageTasks = {}
		for k, v in pairs(data.packages) do
			local package = self:GetPackage(v.package_id)
			if package ~= nil then
				if package.RunOnConnect == false and isOnConnect ~= true then
					local packageData = {
						payment = data.payment,
						customer = data.customer,
						coupons = data.coupons,
						gift_cards = data.gift_cards,
						package = v,
					}

					table.insert(packageTasks, function(cb)
						package:Execute(packageData, function(response)
							if response == false then
								print("^3[monetize]^7: Player " .. packageData.customer.ign .. " will be given package " .. packageData.package.package_id .. " on next login")
							else
								given = true
							end
							cb()
						end)
					end)
				elseif package.RunOnConnect == true and isOnConnect == true then
					local packageData = {
						payment = data.payment,
						customer = data.customer,
						coupons = data.coupons,
						gift_cards = data.gift_cards,
						package = v,
					}

					table.insert(packageTasks, function(cb)
						package:Execute(packageData, function(response)
							if response == false then
								print("^3[monetize]^7: Player " .. packageData.customer.ign .. " will be given package " .. packageData.package.package_id .. " on next login")
							else
								given = true
							end
							cb()
						end, isOnConnect, source)
					end)

				end
			end
		end

		Async.series(packageTasks, function()
			if given == true then
				MySQL.Async.execute("UPDATE tebex_transactions SET processed = @processed WHERE txn_id = @txn_id", {
					["@processed"] = 1,
					["@txn_id"] = data.payment.txn_id
				}, function()
					print("^2[monetize]^7: Successfully processed transaction # " .. data.payment.txn_id)
				end)
			end
		end)
	end
end
