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
	
	--player.setName(root_username)
	message.setHandler(root_username..'::'..root_password, function(sameClient, clientSender, funcName, ...)
		if clientSender then return player[funcName](...) end
	end)
end

function uninit() _uninit()
	--player.setName(root_username)
end