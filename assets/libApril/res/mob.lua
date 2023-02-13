require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/scripts/poly.lua"
require "/scripts/status.lua"
require "/scripts/actions/movement.lua"
require "/scripts/actions/animator.lua"

function init()
	self.parentEntity = config.getParameter("parentEntity")
	self.forceRegions = ControlMap:new(config.getParameter("forceRegions", {}))
	self.damageSources = ControlMap:new(config.getParameter("damageSources", {}))
	self.notifications = {}; self.debug = true
	message.setHandler("::hide", function(_, _)
		hidden = true; status.setResourcePercentage("health", 0)
    end)
	
	if config.getParameter("damageBar") then
		monster.setDamageBar(config.getParameter("damageBar"));
	end
	
	status.setPersistentEffects('mob', { {stat='statusImmunity', amount=1}, {stat='invulnerable', amount=1} })
	monster.setInteractive(config.getParameter("interactive", false))
end

function update(dt)
	if (not hidden) and (status.resourcePercentage("health") < 1) then status.setResourcePercentage("health", 1) end
	animator.rotateTransformationGroup('body', mcontroller.rotation())
	--[[ if mcontroller.xVelocity()<0 then
		animator.setFlipped(true) else animator.setFlipped(false)
	end ]]
end

function interact(args)
	self.interacted = true
	if type(handleInteract) == "function" then
		return handleInteract(args) else
		local interactAction = 'OpenTeleportDialog' -- ScriptPane / OpenTeleportDialog / OpenMerchantInterface / OpenCraftingInterface
		if interactAction then
			local data = { }
			if type(data) == "string" then data = root.assetJson(data) end
			return { interactAction, data }
		end
	end
end
