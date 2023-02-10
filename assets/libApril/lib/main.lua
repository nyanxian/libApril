User.set[1] = function()
	print_lvl = { {}, {} }
	print = function(...) -- table depth: 2 levels
		local log = {...}
		for i, v in ipairs(log) do
			if not (type(v) == 'table') then log[i] = tostring(v)
				else for i1, v1 in pairs(v) do -- level 1
					if not (type(v1) == 'table') then table.insert(print_lvl[1], '	'..tostring(i1)..' = '..tostring(v1))
						else table.insert(print_lvl[1], '	'..tostring(i1)..' = {')
						for i2, v2 in pairs(v1) do -- level 2
							table.insert(print_lvl[2], '		'..tostring(i2)..' = '..tostring(v2))
						end
						table.insert(print_lvl[1], table.concat(print_lvl[2], '\n')..'\n	}'); print_lvl[2] = {}
					end
				end
				log[i] = '<'..tostring(v)..'> {\n'..table.concat(print_lvl[1], '\n')..'\n}\n'; print_lvl[1] = {}
			end
		end
		sb.logInfo('[[\n'..table.concat(log, '\n')..'\n]]')
	end
	
end

User.upd[1] = function()
	dt = args.dt; me = entity.id(); pos = mcontroller.position(); cur = tech.aimPosition(); sit = tech.parentLounging()
	pHand = (world.entityHandItemDescriptor(me,'primary') or nil); aHand = (world.entityHandItemDescriptor(me,'alt') or {})
	lightlvl = world.lightLevel(mcontroller.position()); ls = mcontroller.walking() -- leftShift
	
	if input and input.key then -- github.com/StarExtensions
		a = input.key('A'); b = input.keyDown('B'); c = input.keyDown('C'); d = input.key('D')
		e = input.keyDown('E'); f = input.keyDown('F'); g = input.keyDown('G'); h = input.keyDown('H')
		i = input.keyDown('I'); j = input.keyDown('J'); k = input.keyDown('K'); l = input.keyDown('L')
		m = input.keyDown('M'); n = input.keyDown('N'); o = input.keyDown('O'); p = input.keyDown('P')
		q = input.keyDown('Q'); r = input.keyDown('R'); s = input.key('S'); t = input.keyDown('T')
		u = input.keyDown('U'); v = input.keyDown('V'); w = input.keyDown('W'); x = input.keyDown('X')
		y = input.keyDown('Y'); z = input.keyDown('Z'); sp = input.key('Space'); bsp = input.keyDown('Backspace')
		esc = input.keyDown('Esc'); ent = input.keyDown('Return'); tab = input.keyDown('Tab'); f1 = input.keyDown('F1')
		m1 = input.mouseDown('MouseLeft'); m2 = input.mouseDown('MouseRight'); lc = input.key('LCtrl')
		m1x = input.mouse('MouseLeft'); m2x = input.mouse('MouseRight');
		else
		w = args.moves["up"]; s = args.moves["down"]; a = args.moves["left"]; d = args.moves["right"]
		sp = args.moves["jump"]; m1 = args.moves["primaryFire"]; m2 = args.moves["altFire"]
		f = args.moves["special1"]; g = args.moves["special2"]; h = args.moves["special3"]
	end
	
	-- replace p with any other bind if you don't have StarExtensions
	if p then print(pHand, aHand) end
	
end

User.rm[1] = function() end