StateManager = {
	States = {}
}

function StateManager:Set(key, value)
	self.States[key] = value
end

function StateManager:Get(key)
	return self.States[key]
end

exports('Set', function(...)
	StateManager:Set(...)
end)


exports('Get', function(...)
	return StateManager:Get(...)
end)
