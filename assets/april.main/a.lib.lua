-- Please fill in your data from ['a.load.lua']
	root_username = 'yourName'
	root_password = 'yourPassword'

User = {set = {}, upd = {}, rm = {}}
function plr(funcName, ...)
	return world.sendEntityMessage(entity.id(), root_username..'::'..root_password, funcName, ...):result()
end

function init() -- .set
	require "/scripts/vec2.lua";  require "/scripts/status.lua";
	lib_embed = { -- Your scripts (put in execution order)
		'main',
		'playerdata',
		'entities',
		'chat',
		'animation',
		'tilematrix',
	}
	for _, v in ipairs(lib_embed) do
		require('/lib/'..v..'.lua')
		if type(User.set[v])=='function' then User.set[v]() end
	end
end

function update(args) -- .upd
	for _, v in ipairs(lib_embed) do
		if type(User.upd[v])=='function' then User.upd[v](args) end
	end
end

function uninit() -- .rm
	for _, v in ipairs(lib_embed) do
		if type(User.rm[v])=='function' then User.rm[v]() end
	end
	User = {set = {}, upd = {}, rm = {}}
end

if io then io.popen=nil end; package=nil; os.execute=nil
script_template = [[
User.set.scriptname = function()
	
end

User.upd.scriptname = function()
	
end

User.rm.scriptname = function()
	
end
]]
_changelog = [[^#95f;Changelog
> a.lib.lua : redesign from 2023.02.16
> /lib/*.lua : syntax/performance fixes
> /res/tech.tech : added animation
+ /util/ : new directory
+ /util/edit.lua : nongame script
+ animation.lua : modular mech animation
+ chat.lua : chat commands
+ tilematrix.lua : copy/paste world chunk
+ playerdata.lua : player image presets
]]
_changelog = _changelog: gsub('[\\>]', '^#59f;>^reset;'): gsub('[\\+]', '^#9f5;+^reset;'): gsub('[\\-]', '^#f55;-^reset;'): gsub('[\\:]', '^#f85;:^reset;')
