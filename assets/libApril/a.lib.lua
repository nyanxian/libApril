-- Please fill in your data from ['a.load.lua']
	root_username = 'yourName'
	root_password = 'yourPassword'

User = {set = {}, upd = {}, rm = {}}
function plr(funcName, ...)
	return world.sendEntityMessage(entity.id(), root_username..'::'..root_password, funcName, ...):result()
end

function init() -- @set
	require "/scripts/vec2.lua";  require "/scripts/status.lua"
	
	-- User library
	require '/lib/main.lua';
	require '/lib/entities.lua'
	require '/lib/chat.lua'
	require '/lib/test.lua'
	
	for _, v in pairs(User.set) do v() end
end

function update(args) -- @upd
	for _, v in pairs(User.upd) do v(args) end
end

function uninit() -- @rm
	for _, v in pairs(User.rm) do v() end
	User = {set = {}, upd = {}, rm = {}}
end

io = nil; os.execute = nil
script_template = [[
User.set.funcname = function()
	
end

User.upd.funcname = function()
	
end

User.rm.funcname = function()
	
end
]]
