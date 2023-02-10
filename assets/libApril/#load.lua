_init = init
function init() _init();
	if _G then
		_G.plr = player; sb.logInfo('==> global [_G] environment callback received')
		else sb.logInfo('<== global [_G] environment is locked. Disable "safeScripts" in ["starbound.cfg"] to unlock.')
	end
	player.giveBlueprint = nil
	player.addScannedObject = nil
	player.makeTechUnavailable = nil
	player.unequipTech = nil
	player.playCinematic = nil
	player.makeTechAvailable('April')
	player.enableTech('April')
	player.equipTech('April')
end
