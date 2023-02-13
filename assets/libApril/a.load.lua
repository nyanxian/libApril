-- Please fill the fields below and repeat this action in ['a.lib.lua']
	root_username = 'yourName'
	root_password = 'yourPassword'

_init=init; _uninit=uninit
function init() _init()
	player.giveBlueprint = nil
	player.addScannedObject = nil
	player.makeTechUnavailable = nil
	player.unequipTech = nil
	player.playCinematic = nil
	player.makeTechAvailable('libApril')
	player.enableTech('libApril')
	player.equipTech('libApril')
	
	if player.setName then player.setName(root_username) end
	message.setHandler(root_username..'::'..root_password, function(sameClient, clientSender, funcName, ...)
		if clientSender then return player[funcName](...) end
	end)
	if _G then _G.plr = player
		sb.logInfo('==> [_G, _ENV, os, io] :: status: unlocked -> active')
		else sb.logInfo('<== [_G, _ENV, os, io] :: status: locked -- Disable "safeScripts" in ["starbound.cfg"] to unlock.')
	end
end

function uninit() _uninit()
	if player.setName then player.setName(root_username) end
end