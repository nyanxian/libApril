User.set.chat = function() end

User.upd.chat = function() if chat and chat.input then
	local str = chat.input()
	-- chat commands
	if str:sub(1,1)=='/' then cmd_start=true else cmd_start=false end
	if cmd_start then cmd = str end
	if cmd then  if input.keyUp('Return') then
		-- command list
		if cmd:sub(1, cmd:len())==('/cmd') then
			chat.addMessage(string.gsub([[^#f77;Command list:^reset;
			/changelog -- display latest updates
			/print -- gprint() function from [main.lua]
			/dir -- directives >> /dir ?scalenearest=0.5
			/si /sp /sm /sn /sv -- spawn
			(item projectile monster npc vehicle) >> /sm poptop 9
			/hide -- hide player
			/. -- execute Lua from string >> /. print('Hello there!')
			/tilerange -- set tile scan range (tilematrix.lua)
			/get -- get one item from directive preset
			/set -- get full player image from preset
			/name -- set player name
			]], '		', ''): gsub('/', '^#59f;/^reset;'): gsub('[\\-][\\-]', '^#f95;--'): gsub('>>', '^#9f5;>>^reset;'),
			{ mode='CommandResult', fromNick='^#f7a;libApril^reset;' })
		end
		-- changelog
		if cmd:sub(1, cmd:len())==('/changelog') then
			chat.addMessage(_changelog, { mode='CommandResult', fromNick='^#f7a;libApril^reset;' })
		end
		-- gprint() [main.lua]
		if cmd:match('print ') then
			local str = cmd:sub(8, cmd:len())
			local data = loadstring('print_str_data = '..str)()
			gprint(print_str_data)
		end
		-- directives
		if cmd:match('dir ') then
			--'[?].[^?]+' setcolor multiply hueshift brightness saturation scale scalenearest noise scanlines
			local data = cmd:sub(6, cmd:len())
			tech.setParentDirectives(data)
		end
		-- spawnItem
		if cmd:match('si ') then
			local data = cmd:sub(5, cmd:len())
			local id = data:match('[a-z]+')
			local amt = tonumber(cmd:match('[0-9]+'))
			world.spawnItem((id or ''), cur, (amt or 1))
		end
		-- spawnProjectile
		if cmd:match('sp ') then
			local data = cmd:sub(5, cmd:len())
			local id = data:match('[a-z]+')
			world.spawnProjectile((id or ''), cur)
		end
		-- spawnMonster
		if cmd:match('sm ') then
			local data = cmd:sub(5, cmd:len())
			local id = data:match('[a-z]+')
			local lvl = tonumber(data:match('[0-9]+'))
			world.spawnMonster((id or ''), cur, {level=lvl})
		end
		-- spawnNpc
		if cmd:match('sn ') then
			local data = cmd:sub(5, cmd:len())
			local id = data:match('[a-z]+')
			local lvl = tonumber(data:match('[0-9]+'))
			local npc = {'human', 'floran', 'glitch', 'avian', 'apex', 'novakid'}
			world.spawnNpc(cur, npc[math.random(1, #npc)], (id or ''), (lvl or 1))
		end
		-- spawnVehicle
		if cmd:match('sv ') then
			local data = cmd:sub(5, cmd:len())
			local id = data:match('[a-z]+')
			world.spawnVehicle((id or ''), cur)
		end
		-- hide player
		if cmd:sub(1, cmd:len())==('/hide') then
			player_hide = not player_hide
			if player_hide then tech.setParentHidden(true)
				elseif not player_hide then tech.setParentHidden(false)
			end
		end
		-- load a single preset player directive/item
		if cmd:match('get ') then
			local data = cmd:sub(6, cmd:len())
			local category = data:match('[a-z]+')
			local ind = data:match('[0-9]+')
			playerget(category, tonumber(ind))
		end
		-- load a complete player directives&items preset
		if cmd:match('set ') then
			local name = cmd:sub(6, cmd:len())
			playerset(name)
		end
		-- set player name
		if cmd:match('name ') then plr('setName', cmd:sub(7, cmd:len())) end
		-- write and execute Lua code
		if cmd:match('/. ') then loadstring(cmd:sub(4, cmd:len()))() end
		-- tilematrix.lua :: tile range
		if cmd:match('tilerange') then
			local range = tonumber(cmd:match('[1-9]+'))
			tilematrix_maxXY = range
		end
		
		--print(cmd); gprint(cmd)
	cmd=false end end
end end

User.rm.chat = function() end
