User = {set = {}, upd = {}, rm = {}}
io = nil; os.execute = nil

function init() -- @set
	require "/scripts/vec2.lua";  require "/scripts/status.lua"
	
	-- User library
	require '/lib/main.lua'
	require '/lib/entities.lua'
	
	for _, v in pairs(User.set) do v() end
end

function update(args) -- @upd
	for _, v in pairs(User.upd) do v(args) end
end

function uninit() -- @rm
	for _, v in pairs(User.rm) do v() end
	User = {set = {}, upd = {}, rm = {}}
end

script_template = [[
User.set.funcname = function()
	
end

User.upd.funcname = function()
	
end

User.rm.funcname = function()
	
end
]]
