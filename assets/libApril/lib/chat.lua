User.set.funcname = function()
end

User.upd.funcname = function() if chat and chat.input then
	local str = chat.input()
	-- chat commands
	if str:sub(1,1)=='/' then cmd_start=true else cmd_start=false end
	if cmd_start then cmd = str end
	if cmd then  if input.keyUp('Return') then
		-- commands list
		if cmd:sub(1, cmd:len())==('/cmd') then
			chat.addMessage([[Commands list:
		/dir -- directives, ex:: /dir ?scalenearest=0.5
		/si /sp /sm /sn /sv -- spawn item/projectile/monster/npc/vehicle, ex:: /sm poptop 9
		/hide -- hide player
		/. -- execute Lua from string, ex:: /. print('Hello there!')
		]], { mode='CommandResult', portrait='/assetmissing.png', fromNick='April@nyanxian', showPane=true })
		end
		-- directives
		if cmd:match('dir') then
			local _mul = (cmd:match("?multiply=........") or "")
			local _hue = (cmd:match("?hueshift=...") or "")
			local _shade = (cmd:match("?brightness=...") or "")
			local _satur = (cmd:match("?saturation=...") or "")
			local _contr = (cmd:match("?contrast=...") or "")
			local _scale = (cmd:match("?scalenearest=...") or "")
			local _noise = (cmd:match("?noise=.+") or "")
			local _scan = (cmd:match("?scanlines=.+") or "")
			tech.setParentDirectives(_mul.._hue.._shade.._satur.._contr.._scale.._noise.._scan)
		end
		-- spawnItem
		if cmd:match('si') then
			local data = cmd:sub(5, cmd:len())
			local id = data:match('[a-z]+')
			local amt = tonumber(cmd:match('[1-9]+'))
			world.spawnItem((id or ''), cur, (amt or 1))
		end
		-- spawnProjectile
		if cmd:match('sp') then
			local data = cmd:sub(5, cmd:len())
			local id = data:match('[a-z]+')
			world.spawnProjectile((id or ''), cur)
		end
		-- spawnMonster
		if cmd:match('sm') then
			local data = cmd:sub(5, cmd:len())
			local id = data:match('[a-z]+')
			local lvl = tonumber(data:match('[1-9]+'))
			world.spawnMonster((id or ''), cur, {level=lvl})
		end
		-- spawnNpc
		if cmd:match('sn') then
			local data = cmd:sub(5, cmd:len())
			local id = data:match('[a-z]+')
			local lvl = tonumber(data:match('[1-9]+'))
			local npc = {'human', 'floran', 'glitch', 'avian', 'apex', 'novakid'}
			world.spawnNpc(cur, npc[math.random(1, #npc)], (id or ''), (lvl or 1))
		end
		-- spawnVehicle
		if cmd:match('sv') then
			local data = cmd:sub(5, cmd:len())
			local id = data:match('[a-z]+')
			world.spawnVehicle((id or ''), cur)
		end
		-- hide player
		if cmd:match('hide') then
			player_hide = not player_hide
			if player_hide then tech.setParentHidden(true)
				elseif not player_hide then tech.setParentHidden(false)
			end
		end
		-- write and execute Lua code
		if cmd:match('/. ') then loadstring(cmd:sub(4, cmd:len()))() end
		
		print(cmd); gprint(cmd); cmd=false
	end end
end end

User.rm.funcname = function()
end
