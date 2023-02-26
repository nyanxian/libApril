User.set.animation = function()
	parts = {'frontLegJoint', 'frontBoosterFront', 'rightArmFullbright', 'backLeg', 'frontBoosterFullbright', 'frontLeg', 'backLegFullbright',
		'bodyFullbright', 'frontLegFullbright', 'bodyFront', 'leftArm', 'bodyBack', 'frontBoosterBack', 'rightArm', 'backBoosterBack',
		'leftArmFullbright', 'backBoosterFront', 'hips', 'backBoosterFullbright', 'backLegJoint'}
	animationParts = config.getParameter('animationParts')
	for i, _ in pairs(animationParts) do
		animator.setPartTag(i, "directives", '?scalenearest=0')
	end
	
	-- your directives below, template --> animator.setPartTag('rightArm', "directives", '')
	animator.setPartTag('backBoosterBack', "directives", '?scalenearest=0')
end

User.upd.animation = function()
	
end

User.rm.animation = function()
	
end