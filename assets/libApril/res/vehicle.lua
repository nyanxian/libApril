require "/scripts/vec2.lua"
require "/scripts/util.lua"

function init()
	self.parentEntity = config.getParameter("parentEntity")
	self.despawning = false
	message.setHandler('::hide', function(_, _)
		despawn()
	end)
end

function update(dt)
end

function despawn()
	vehicle.destroy()
end