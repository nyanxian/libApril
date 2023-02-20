User.set.main = function()
	lightlvl = world.lightLevel(mcontroller.position()); pos = mcontroller.position()
	mcontroller.controlParameters({ collisionEnabled=true, physicsEffectCategories={root_username} })
	
	print_lvl = { {}, {} }
	print = function(...) -- ['starbound.log'] print, 2 levels
		local log = {...}
		for i, v in ipairs(log) do
			if not (type(v) == 'table') then log[i] = '	'..tostring(v)
				else for i1, v1 in pairs(v) do -- level 1
					if not (type(v1) == 'table') then table.insert(print_lvl[1], '		'..tostring(i1)..' = '..tostring(v1))
						else table.insert(print_lvl[1], '		'..tostring(i1)..' = {')
						for i2, v2 in pairs(v1) do -- level 2
							table.insert(print_lvl[2], '			'..tostring(i2)..' = '..tostring(v2))
						end
						table.insert(print_lvl[1], table.concat(print_lvl[2], '\n')..'\n		}'); print_lvl[2] = {}
					end
				end
				log[i] = '	'..i..' = {\n'..table.concat(print_lvl[1], '\n')..'\n	}\n'; print_lvl[1] = {}
			end
		end
		sb.logInfo('[[\n'..table.concat(log, '\n')..'\n]]')
		return table.concat(log, '\n')
	end
	
	gprint = function(...) -- graphical print (chat / around player)
		local data = print(...)
		if chat and chat.addMessage then -- github.com/StarExtensions
			chat.addMessage('\n'..data:gsub('	', '  '), { mode='CommandResult', fromNick='^#59f;print :: result^reset;' })
			else
			world.spawnProjectile("roar", pos, me, {0,0}, true, { timeToLive = 0.0, damageType = "nodamage", processing = "?multiply=FFFFFF00",
				actionOnReap = jarray(), actionOnTimeout = jarray(), actionOnCollide = jarray(), periodicActions = {
				{ ["time"] = 0.0, ["repeat"] = false, action = "particle", specification = {
					type = "text",  size = 0.35, layer = "front", destructionAction = "fade",
					collidesForeground = false, ignoreWind = true, text = data:gsub('	', '  '),
					position = {math.random(-30, 30)*0.1, math.random(-45, 0)*0.1},
					color = {math.random(150, 255), math.random(150, 255), math.random(150, 255)},
					timeToLive = (data:len()*0.02)+0.6, destructionTime = 0.3
				}} }
			})
		end
	end
	
	text = function(vec2, str)
		world.spawnProjectile("seed", vec2, me, {0,0}, false, { timeToLive = 0.0, damageType = "nodamage", processing = "?multiply=FFFFFF00",
			actionOnReap = jarray(), actionOnTimeout = jarray(), actionOnCollide = jarray(), periodicActions = {
			{ ["time"] = 0.0, ["repeat"] = false, action = "particle", specification = {
				type = "text",  size = 0.35, layer = "front", destructionAction = "fade",
				collidesForeground = false, ignoreWind = true, text = str, timeToLive = 0.7,
				position = {0, 0}, color = {255, 50, 50}, destructionTime = 0.2
			}} }
		})
	end
	
	stun = function()
		mcontroller.setVelocity({0, 0}); mcontroller.addMomentum({0, 0})
		mcontroller.zeroG(); mcontroller.setPosition(mcontroller.position())
		mcontroller.controlParameters({collisionEnabled=false, physicsEffectCategories={root_username}, movementSuppressed=true})
	end
	
end

User.upd.main = function(args)
	dt=args.dt; me=entity.id(); pos=mcontroller.position(); cur=tech.aimPosition(); vel=mcontroller.velocity()
	pHand=(world.entityHandItemDescriptor(me,'primary') or nil); aHand=(world.entityHandItemDescriptor(me,'alt') or {})
	sit=tech.parentLounging(); lightlvl=world.lightLevel(mcontroller.position()); ls=mcontroller.walking() -- leftShift
	
	if mcontroller.running() or mcontroller.walking() then moving=true else moving=false end
	if input and input.key then -- github.com/StarExtensions
		a=input.key('A'); b=input.keyDown('B'); c=input.keyDown('C'); d=input.key('D')
		e=input.keyDown('E'); f=input.keyDown('F'); g=input.keyDown('G'); h=input.keyDown('H')
		i=input.keyDown('I'); j=input.keyDown('J'); k=input.keyDown('K'); l=input.keyDown('L')
		m=input.keyDown('M'); n=input.keyDown('N'); o=input.keyDown('O'); p=input.keyDown('P')
		q=input.keyDown('Q'); r=input.keyDown('R'); s=input.key('S'); t=input.keyDown('T')
		u=input.keyDown('U'); v=input.keyDown('V'); w=input.keyDown('W'); x=input.keyDown('X')
		y=input.keyDown('Y'); z=input.keyDown('Z'); sp=input.key('Space'); bsp=input.keyDown('Backspace')
		esc=input.keyDown('Esc'); ent=input.keyDown('Return'); tab=input.keyDown('Tab');
		m1=input.mouseDown('MouseLeft'); m2=input.mouseDown('MouseRight'); ctrl=input.key('LCtrl')
		m1x=input.mouse('MouseLeft'); m2x=input.mouse('MouseRight'); sbl=input.keyDown('['); sbr=input.keyDown(']');
		f1=input.keyDown('F1'); f2=input.keyDown('F2'); f3=input.keyDown('F3')
		x1=input.keyDown('1'); x2=input.keyDown('2'); x3=input.keyDown('3'); x4=input.keyDown('4'); x5=input.keyDown('5')
		x6=input.keyDown('6'); x7=input.keyDown('7'); x8=input.keyDown('8'); x9=input.keyDown('9'); x0=input.keyDown('0')
		else
		w=args.moves["up"]; s=args.moves["down"]; a=args.moves["left"]; d=args.moves["right"]
		sp=args.moves["jump"]; m1=args.moves["primaryFire"]; m2=args.moves["altFire"]
		f=args.moves["special1"]; g=args.moves["special2"]; h=args.moves["special3"]
	end
	-- replace p with any other bind if you don't have StarExtensions
	if p then gprint(pHand, aHand); print(pHand, aHand) end
	
end

User.rm[1] = function() end