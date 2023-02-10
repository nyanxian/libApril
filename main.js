function emi(id) { if (document.getElementById(id)) { return document.getElementById(id) } }
function percent(this_num, of_the) { return Math.round( (100 * this_num) / of_the ) }
function print(...msg) {
	var em = emi("terminal")
	msg.forEach(function(message) {
		if (em) {
			em.innerHTML = em.innerHTML + '['+time()+'] '+message
			em.appendChild(document.createElement('br'))
		}
		console.log('['+time()+'] '+message)
	})
}
function time() {
	var get_time = new Date()
	var hour = get_time.getHours()
	var min = get_time.getMinutes()
	var sec = get_time.getSeconds()
	if (hour.toString().length==1) {hour = '0'+hour}
	if (min.toString().length==1) {min = '0'+min}
	if (sec.toString().length==1) {sec = '0'+sec}
	return hour+":"+min+':'+sec
}
function fullscreen() {
	var em = document.body
	if ( !em.fs || em.fs === 'false' ) {
		if (em.requestFullscreen) { em.requestFullscreen() }
		else if (em.webkitRequestFullscreen) { em.webkitRequestFullscreen() }
		else if (em.msRequestFullscreen) { em.msRequestFullscreen() }
		em.fs = 'true'
	}
	else if ( em.fs === 'true' ) {
		if (document.exitFullscreen) { document.exitFullscreen() }
		else if (document.webkitExitFullscreen) { document.webkitExitFullscreen() }
		else if (document.msExitFullscreen) { document.msExitFullscreen() }
		em.fs = 'false'
	}
}
function href(https, _b) {
	if (_b) { window.open(https, '_blank') }
	else { window.open(https, '_self') }
}
function pattern(CSSVar, val) { document.documentElement.style.setProperty('--'+CSSVar, val) }
function vport(func_desktop, func_mobile) {
	let h = window.innerHeight
	let w = window.innerWidth
	if ( percent(h, w) > 100 ) { func_mobile() }
	else { func_desktop() }
}
function loadstring(str) {
	var script = document.createElement('script')
	script.id = 'loadstring-temp_script'
	script.innerHTML = str
	document.documentElement.appendChild(script)
	emi('loadstring-temp_script').remove()
}
function slide(id, dir, _init) {
	// Create [slides] and slides[id] arrays if they doesn't exist
	if (typeof slides == 'undefined') { slides = {} }
	if (!slides[id] && _init) { slides[id]=[]; for (let i=0; i<(_init+1); i++) { slides[id].push(i) } }
	if (dir=='R') { // Change class for this [id] and switch to next
		if (emi(id+slides[id][0])) {
			emi(id+slides[id][0]).classList.remove("slide", "slideR", "slideL")
			emi(id+slides[id][0]).style.animation = null
			emi(id+slides[id][0]).classList.add("slided")
		}
		slides[id][0] = slides[id][0]+1
		if (emi(id+slides[id][0])) { // Change class for the new [id]
			emi(id+slides[id][0]).classList.remove("slided")
			emi(id+slides[id][0]).classList.add("slide", "slideR")
		} else { // If next [id] doesn't exist, set index to 1 and change class
			slides[id][0] = 1
			emi(id+slides[id][0]).classList.remove("slided")
			emi(id+slides[id][0]).classList.add("slide", "slideR")
		}
	}
	if (dir=='L') { // Change class for this [id] and switch to previous
		if (emi(id+slides[id][0])) {
			emi(id+slides[id][0]).classList.remove("slide", "slideL", "slideR")
			emi(id+slides[id][0]).style.animation = null
			emi(id+slides[id][0]).classList.add("slided")
		}
		slides[id][0] = slides[id][0]-1
		if (emi(id+slides[id][0])) { // Change class for the new [id]
			emi(id+slides[id][0]).classList.remove("slided")
			emi(id+slides[id][0]).classList.add("slide", "slideL")
		} else { // If previous [id] doesn't exist, set index to [max] and change class
			slides[id][0] = (slides[id].length-1)
			emi(id+slides[id][0]).classList.remove("slided")
			emi(id+slides[id][0]).classList.add("slide", "slideL")
		}
	}
	// Check if [id] with [dir] index exists and change classes for this and selected [id]
	if (typeof dir=='number' && emi(id+dir)) {
		if (emi(id+slides[id][0])) {
			emi(id+slides[id][0]).classList.remove("slide", "slideR", "slideL")
			emi(id+slides[id][0]).style.animation = null
			emi(id+slides[id][0]).classList.add("slided")
		}
		slides[id][0] = dir
		emi(id+slides[id][0]).classList.remove("slided")
		emi(id+slides[id][0]).classList.add("slide")
	} //2022.11.05 :: Assigns 3 classes, clears animation states
}
function highlight(in_id, out_id) {
	var txt = emi(in_id).value
	var patterns = {
		esc: /<(.*?)>/, //...nevermind
		operator: [ '{', '}', '(', ')', '[', ']', ';', ',', '==', ' =', ': ', '-', '+', '.', ' > ', ' < ', ' / ' ],
		instructor: [ 'function', ' then', ' end', '	end', '\nend', 'if ', ' do', 'else', 'for ', 'while ', 'true', 'false', 'not ', ' or ', 'in ', ' and ', 'nil', 'local ', 'return ' ],
		lua_env: [ 'tostring', 'loadfile', 'table', 'ipairs', 'select', 'error', 'pairs', 'debug', 'package', 'io.', 'next', 'dofile', 'os.', '_G', '.create',
		'getmetatable', 'rawget', 'collectgarbage', 'xpcall', 'print', 'setmetatable', 'type', 'tonumber', 'rawequal', 'math', //'arg'
		'assert', 'rawlen', 'require', 'utf8', 'bit32', 'string', 'pcall', 'load', 'rawset', 'coroutine', '_VERSION', 'execute', '.write', 'load', 'clock' ],
		number: [ ' 1', ' 2', ' 3', ' 4', ' 5', ' 6', ' 7', ' 8', ' 9', ' 0', // '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
		'.1', '.2', '.3', '.4', '.5', '.6', '.7', '.8', '.9', '.0', '-1', '-2', '-3', '-4', '-5', '-6', '-7', '-8', '-9', '-0',
		'(1', '(2', '(3', '(4', '(5', '(6', '(7', '(8', '(9', '(0', '1)', '2)', '3)', '4)', '5)', '6)', '7)', '8)', '9)', '0)',
		'[1', '[2', '[3', '[4', '[5', '[6', '[7', '[8', '[9', '[0', '1]', '2]', '3]', '4]', '5]', '6]', '7]', '8]', '9]', '0]', 
		'{1', '{2', '{3', '{4', '{5', '{6', '{7', '{8', '{9', '{0', '1}', '2}', '3}', '4}', '5}', '6}', '7}', '8}', '9}', '0}',
		],
	}
	
	txt = txt.replaceAll('-- ', '<x style="color:#fff">-- ')
	txt = txt.replaceAll('\n', '\n</x>')
	txt = txt.replaceAll('</x>end', 'end')
	
	patterns.number.forEach(function(i) {
		txt = txt.replaceAll(i, '<x style="color:#fc8">'+i+'</x>')
	})
	patterns.lua_env.forEach(function(i) {
		txt = txt.replaceAll(i, '<x style="color:#6af">'+i+'</x>')
	})
	patterns.operator.forEach(function(i) {
		txt = txt.replaceAll(i, '<x style="color:#f49">'+i+'</x>')
	})
	patterns.instructor.forEach(function(i) {
		txt = txt.replaceAll(i, '<x style="color:#f9f">'+i+'</x>')
	})
	
	txt = txt.replaceAll('\n', '<br>')
	txt = txt.replaceAll('	', '　　')
	
	emi(out_id).innerHTML = txt
}
function twemojiParse() { twemoji.parse(document.documentElement, {folder: 'svg', ext: '.svg'}) }

setInterval(function(){
	emi('highlight').scrollLeft = emi('raw').scrollLeft
	emi('highlight').scrollTop = emi('raw').scrollTop
}, 500)
function lua(str) {
	var script = document.createElement('script')
	script.id = 'lua'
	script.type = 'application/lua'
	script.innerHTML = str
	document.documentElement.appendChild(script)
	emi('lua').remove()
}
function terminal() {
	var input = emi('commands').value
	var out = function(str) { print("<x style='color: #be8'>"+str+'</x>') }
	print(input)
	
	if (input=='/help') {
		out(`Available commands:<br>
		/help -- this list<br>
		/run [string_js] -- execute JS from string<br>
		/lua -- execute Lua from editor<br>
		/fs -- fullscreen<br>
		/res -- download resource package
		`)
	}
	if (input.match(/\/run .*/)) { var input = input.replace('/run ', '');loadstring(input) }
	if (input=='/lua') { lua(emi('raw').value); out('Check developer console for printed information') }
	if (input=='/fs') { fullscreen() }
	if (input=='/res') { out(`<a class='text x' href='assets/libApril.zip' download>libApril.zip</a>`) }
	
	emi('commands').value=''
}

pass=0; source=[0,
`-- Let's open the terminal and write: /lua

-- comment
a = 'example'
b = 1
c = {}
d = function() end
e = coroutine.create(function() end)
print(type(a), type(b), type(c), type(d), type(e), type(f))

for i = 1, 3 do print('i = '..i) end`,


`User = {set = {}, upd = {}, rm = {}}
io = nil; os.execute = nil

function init() -- @set
	require "/scripts/vec2.lua";  require "/scripts/status.lua";
	
	-- User library
	require '/lib/main.lua'
	
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
]]`,


`User.set[1] = function()
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
						table.insert(print_lvl[1], table.concat(print_lvl[2], '\\n')..'\\n	}'); print_lvl[2] = {}
					end
				end
				log[i] = '<'..tostring(v)..'> {\\n'..table.concat(print_lvl[1], '\\n')..'\\n}\\n'; print_lvl[1] = {}
			end
		end
		sb.logInfo('[[\\n'..table.concat(log, '\\n')..'\\n]]')
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

User.rm[1] = function() end`,


`User.set.entities = function()
	lightOn = true
end

User.upd.entities = function()
	
end`,

`require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/scripts/poly.lua"
require "/scripts/status.lua"
require "/scripts/actions/movement.lua"
require "/scripts/actions/animator.lua"

function init()
	script.setUpdateDelta(1)
	self.parentEntity = config.getParameter("parentEntity")
	monster.setInteractive(config.getParameter("interactive", true))
end

function update(dt) end

function interact(args)
	setInteracted(args)
	if type(handleInteract) == "function" then
		return handleInteract(args) else
		local interactAction = 'OpenTeleportDialog' -- ScriptPane / OpenTeleportDialog / OpenMerchantInterface / OpenCraftingInterface
		if interactAction then
			local data = {
				destinations = {
					{name = "Back To Home", planetName = "Home", warpAction = "OwnShip", icon = "beamup"},
					{name = "Warp to Outpost", planetName = "Outpost", warpAction = "InstanceWorld:outpost=outpost", icon = "outpost"},
					{name = "Warp to Ark", planetName = "Ark", warpAction = "InstanceWorld:outpost=arkteleporter", icon = "ark"},
					{name = "Electric", planetName = "Ancient Vault", warpAction = "InstanceWorld:ancientvault_electric", icon = "savannah"},
					{name = "Ice", planetName = "Ancient Vault", warpAction = "InstanceWorld:ancientvault_ice", icon = "arctic"},
					{name = "Poison", planetName = "Ancient Vault", warpAction = "InstanceWorld:ancientvault_poison", icon = "toxic"},
					{name = "Fire", planetName = "Ancient Vault", warpAction = "InstanceWorld:ancientvault_fire", icon = "magma"},
					{name = "Human Mission", planetName = "Lunar Base", warpAction = "InstanceWorld:lunarbase", icon = "moon"},
					{name = "Floran Mission", planetName = "Hunting Caverns", warpAction = "InstanceWorld:floranmission1", icon = "forest"},
					{name = "Hylotl Mission", planetName = "Pagoda Library", warpAction = "InstanceWorld:hylotlmission1", icon = "ocean"},
					{name = "Avian Mission", planetName = "Kluex Temple", warpAction = "InstanceWorld:avianmission1", icon = "desert"},
					{name = "Apex Mission", planetName = "Miniknog Stronghold", warpAction = "InstanceWorld:apexmission1", icon = "jungle"},
					{name = "Glitch Mission", planetName = "The Barons Keep", warpAction = "InstanceWorld:glitchmission1", icon = "garden"},
					{name = "Final Boss", planetName = "The Ruin", warpAction = "InstanceWorld:tentaclemission", icon = "tentacle"},
				},
				config = "/interface/warping/returnark.config",
				includePlayerBookmarks = true,
				canBookmark = false,
				includePartyMembers = true
			}
			
			if type(data) == "string" then data = root.assetJson(data) end
			return { interactAction, data }
		end
	end
end`,



`User.set.entities = function()
	lightOn = true
end

User.upd.entities = function()
	-- [L] firefly - light source
	if l then lightOn = not lightOn end
	if firefly and world.entityExists(firefly) then
		if not lightOn then world.sendEntityMessage(firefly, '::hide') end
		local R = world.distance(pos, world.entityPosition(firefly))
		-- init
		if not firefly_init then
			firefly_init = true;  firefly_reverse = false
			world.callScriptedEntity(firefly, "animator.rotateTransformationGroup", 'body', -0.2)
		end
		-- following
		if ((R[1]>16) or (R[1]<-16) or (R[2]>10) or (R[2]<-10)) and (faceDir == -1) then
			world.callScriptedEntity(firefly, "mcontroller.setVelocity", world.distance(vec2.add(pos, {3, 2}), world.entityPosition(firefly)) )
		end
		if ((R[1]>16) or (R[1]<-16) or (R[2]>10) or (R[2]<-10)) and (faceDir == 1) then
			world.callScriptedEntity(firefly, "mcontroller.setVelocity", world.distance(vec2.add(pos, {-3, 2}), world.entityPosition(firefly)) )
		end
		-- facing direction
		local face = world.callScriptedEntity(firefly, "mcontroller.xVelocity")
		if face<0 then
			world.callScriptedEntity(firefly, "animator.setFlipped", true)
			else world.callScriptedEntity(firefly, "animator.setFlipped", false)
		end
		-- soar animation
		firefly_rot = ((firefly_rot or 0) + 1) % 100
		if firefly_rot>=99 then firefly_reverse = not firefly_reverse end
		if not firefly_reverse then
			world.callScriptedEntity(firefly, "mcontroller.setRotation", firefly_rot*0.0004)
			world.callScriptedEntity(firefly, "animator.translateTransformationGroup", 'body', {0, -firefly_rot*0.0003})
			else world.callScriptedEntity(firefly, "mcontroller.setRotation", -firefly_rot*0.0004)
			world.callScriptedEntity(firefly, "animator.translateTransformationGroup", 'body', {0, firefly_rot*0.0003})
		end
		-- wander
		if firefly_rot==1 then
			firefly_destination = vec2.add(pos, { math.random(-100, 100)*0.2, math.random(-20, 60)*0.2 })
			world.callScriptedEntity(firefly, "mcontroller.setVelocity", world.distance( firefly_destination, world.entityPosition(firefly) ) )
		end
		
	else if lightOn then firefly = world.spawnMonster('wisper', pos, {
			clientEntityMode = 'ClientMasterAllowed',
			parentEntity = '...',
			type = 'wisper',
			shortdescription = "firefly",
			description = "...",
			nametagColor = {255, 255, 255},
			damageTeamType = 'assistant', -- assistant / enemy
			monsterClass = 'boss', -- rare / boss
			damageBar = 'None', -- None / Special
			
			scripts = {'/res/mob.lua'},
			scale = 0.5,
			
			animation = 'firewisper.animation',
			renderLayer = 'FrontParticle+8000001',
			bodyMaterialKind = 'wood',
			dropPools = jarray(),
			categories = { 'firewisper' },
			behavior = 'monster',
			knockoutTime = 0.3,
			knockoutAnimationStates = nil,
			deathParticles = 'deathPoof',
			knockoutEffect = '',
			touchDamage = { poly = { {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0} } },
			metaBoundBox = {0, 0, 0, 0},
			
			movementSettings = { collisionPoly = { {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0} } },
			behaviorConfig = {
				damageOnTouch = false,
				targetQueryRange = 35,
				targetOnDamage = true,
				keepTargetInSight = false,
				keepTargetInRange = 50,
				targetOutOfSightTime = 5.0,
				hurtTime = 0.0,
				hurtWaitForGround = false,
				damageTakenActions = nil,
				foundTargetActions = nil,
				fleeActions = nil,
				hostileActions = nil,
				periodicActions = nil,
				approachActions = nil,
				followActions = nil,
				wanderActions = nil,
				concurrentActions = nil,
				concurrentHostileActions = nil
			},
			statusSettings = {
				primaryScriptSources = { '/stats/monster_primary.lua' },
				primaryScriptDelta = 0,
				statusProperties = { targetMaterialKind = 'wood' },
				appliesEnvironmentStatusEffects = false,
				appliesWeatherStatusEffects = false,
				minimumLiquidStatusEffectPercentage = 0.0,
				stats = { maxHealth = { baseValue = 70 } },
				resources = {
					stunned = {
						deltaValue = -1.0,
						initialValue = 0.0
					},
					health = {
						maxStat = 'maxHealth',
						deltaStat = 'healthRegen',
						defaultPercentage = 100
					}
				}
			},

			mouthOffset = {0, 0},
			feetOffset = {0, -8},
			capturable = false,
			captureHealthFraction = 0.0,
			captureCollectables = {},
			
			parts = { 'body', 'carcase', 'wings', 'glow'}, --1
			animationCustom = {

				transformationGroups = { --2
					body = {interpolated = true},
					carcase = {interpolated = true},
					wings = {interpolated = true},
					glow = {interpolated = true},
				},

				animatedParts = {
					parts = { --3

						body = {
							properties = {
								zLevel = 1,
								transformationGroups = { 'body' },
								offset = { 0.0, 0.0}
							},
							partStates = {
								body = {
									idle = { properties = {image = ''} },
									fly = { properties = {image = ''} },
									firewindup = { properties = {image = ''} },
									fire = { properties = {image = ''} }
								},
								damage = {
									stunned = { properties = {image = ''} }
								}
							}
						},
						wings = {
							properties = {
								zLevel = 3, offset = {0, 0},
								transformationGroups = {'body', 'carcase', 'wings'},
							},
							partStates = {
								wings = {
									idle = { properties = {image = '/assetmissing.png?setcolor=fff?replace;fff0=fff?scalenearest=1?crop=0;0;24;17?blendmult=/objects/outpost/customsign/signplaceholder.png;0;-8?replace;06000501=38322F;06000601=0F0B08;07000401=0F0B08;07000501=38322F;07000601=23191164;07000701=0F0B08;08000301=38322F;08000401=23191164;08000501=23191164;08000601=38322F;08000701=23191164;08000801=38322F;09000201=0F0B08;09000301=23191164;09000401=0F0B08;09000501=23191164;09000601=0F0B08;09000701=23191164;09000801=0F0B08;10000301=23191164;10000401=23191164;10000501=442E1B;10000601=442E1B;10000701=2B1D11;11000301=442E1B;11000401=442E1B;11000501=2B1D11;11000601=2B1D11;11000701=9E4B03;12000301=2B1D11;12000401=2B1D11;12000501=9E4B03;12000601=723B0D;13000301=723B0D;13000401=9E4B03;14000201=723B0D?fade;80ff80;0.0001518?replace;fff=0000'} },
									idle1 = { properties = {image = '/assetmissing.png?setcolor=fff?replace;fff0=fff?scalenearest=1?crop=0;0;24;17?blendmult=/objects/outpost/customsign/signplaceholder.png;0;-8?replace;05000501=0F0B08;05000601=38322F;06000401=38322F;06000501=23191164;06000601=23191164;06000701=38322F;07000301=0F0B08;07000401=23191164;07000501=38322F;07000601=23191164;07000701=38322F;08000201=0F0B08;08000301=38322F;08000401=23191164;08000501=0F0B08;08000601=23191164;08000701=0F0B08;09000201=0F0B08;09000301=23191164;09000401=0F0B08;09000501=23191164;09000601=0F0B08;10000301=23191164;10000401=23191164;10000501=442E1B;10000601=442E1B;10000701=2B1D11;11000301=442E1B;11000401=442E1B;11000501=2B1D11;11000601=2B1D11;11000701=9E4B03;12000301=2B1D11;12000401=2B1D11;12000501=9E4B03;12000601=723B0D;13000301=723B0D;13000401=9E4B03;14000201=723B0D?fade;80ff80;0.0001518?replace;fff=0000'} },
									idle2 = { properties = {image = '/assetmissing.png?setcolor=fff?replace;fff0=fff?scalenearest=1?crop=0;0;24;17?blendmult=/objects/outpost/customsign/signplaceholder.png;0;-8?replace;05000301=38322F;05000401=38322F;05000501=0F0B08;06000301=0F0B08;06000401=38322F;06000501=23191164;06000601=0F0B08;07000201=0F0B08;07000301=23191164;07000401=0F0B08;07000501=23191164;07000601=38322F;08000101=38322F;08000201=38322F;08000301=23191164;08000401=23191164;08000501=38322F;09000101=0F0B08;09000201=23191164;09000301=38322F;09000401=23191164;09000501=0F0B08;10000201=0F0B08;10000301=23191164;10000401=0F0B08;10000501=442E1B;10000601=442E1B;10000701=2B1D11;11000301=442E1B;11000401=442E1B;11000501=2B1D11;11000601=2B1D11;11000701=9E4B03;12000301=2B1D11;12000401=2B1D11;12000501=9E4B03;12000601=723B0D;13000301=723B0D;13000401=9E4B03;14000201=723B0D?fade;80ff80;0.0001518?replace;fff=0000'} },
									idle3 = { properties = {image = '/assetmissing.png?setcolor=fff?replace;fff0=fff?scalenearest=1?crop=0;0;24;17?blendmult=/objects/outpost/customsign/signplaceholder.png;0;-8?replace;05000201=38322F;05000301=0F0B08;06000101=38322F;06000201=0F0B08;06000301=23191164;06000401=0F0B08;07000101=0F0B08;07000201=23191164;07000301=38322F;07000401=38322F;08000101=38322F;08000201=23191164;08000301=23191164;08000401=38322F;09000101=0F0B08;09000201=38322F;09000301=0F0B08;09000401=0F0B08;10000201=0F0B08;10000301=23191164;10000401=0F0B08;10000501=442E1B;10000601=442E1B;10000701=2B1D11;11000301=442E1B;11000401=442E1B;11000501=2B1D11;11000601=2B1D11;11000701=9E4B03;12000301=2B1D11;12000401=2B1D11;12000501=9E4B03;12000601=723B0D;13000301=723B0D;13000401=9E4B03;14000201=723B0D?fade;80ff80;0.0001518?replace;fff=0000'} },
									idle4 = { properties = {image = '/assetmissing.png?setcolor=fff?replace;fff0=fff?scalenearest=1?crop=0;0;24;17?blendmult=/objects/outpost/customsign/signplaceholder.png;0;0?replace;05000801=0F0B08;06000701=38322F;06000801=23191164;07000701=38322F;07000801=38322F;08000701=0F0B08;08000801=23191164;09000801=0F0B08?fade;80ff80;0.0001518?blendmult=/objects/outpost/customsign/signplaceholder.png;0;-8?replace;05000101=0F0B08;06000101=0F0B08;06000201=38322F;07000101=23191164;07000201=0F0B08;08000101=0F0B08;08000201=38322F;08000301=38322F;09000101=23191164;09000201=23191164;09000301=38322F;09000501=442E1B;09000601=442E1B;09000701=2B1D11;10000101=38322F;10000201=0F0B08;10000301=0F0B08;10000401=442E1B;10000501=2B1D11;10000601=2B1D11;10000701=9E4B03;11000301=442E1B;11000401=2B1D11;11000501=9E4B03;11000601=723B0D;12000301=2B1D11;12000401=9E4B03;13000301=723B0D;14000201=723B0D?fade;80ff80;0.0001518?replace;fff=0000'} },
									idle5 = { properties = {image = '/assetmissing.png?setcolor=fff?replace;fff0=fff?scalenearest=1?crop=0;0;24;17?blendmult=/objects/outpost/customsign/signplaceholder.png;0;0?replace;06000701=0F0B08;06000801=0F0B08;07000601=38322F;07000701=23191164;07000801=38322F;08000601=0F0B08;08000701=23191164;08000801=38322F;09000701=0F0B08;09000801=23191164;10000801=38322F?fade;80ff80;0.0001518?blendmult=/objects/outpost/customsign/signplaceholder.png;0;-8?replace;07000101=0F0B08;08000101=23191164;08000201=0F0B08;08000501=2B1D11;09000101=23191164;09000201=38322F;09000401=442E1B;09000501=442E1B;09000601=9E4B03;10000101=0F0B08;10000201=23191164;10000301=38322F;10000401=442E1B;10000501=2B1D11;10000601=723B0D;11000101=38322F;11000201=0F0B08;11000301=442E1B;11000401=2B1D11;11000501=9E4B03;12000301=2B1D11;12000401=9E4B03;13000301=723B0D;14000201=723B0D?fade;80ff80;0.0001518?replace;fff=0000'} },
								}
							}
						},
						glow = {
							properties = {
								zLevel = 2, offset = {0, 0}, fullbright = true,
								transformationGroups = {'body', 'carcase', 'glow'},
								image = '/assetmissing.png?setcolor=fff?replace;fff0=fff?scalenearest=1?crop=0;0;24;17?blendmult=/objects/outpost/customsign/signplaceholder.png;0;0?replace;03000601=82AF28;04000501=82AF28;04000601=CDE03C;04000701=5D871F;05000501=5D871F;05000601=82AF28;05000701=CDE03C;05000801=82AF28;06000501=82AF28;06000601=CDE03C;06000701=82AF28;06000801=5D871F;07000601=82AF28;07000701=CDE03C;07000801=82AF28;08000601=5D871F?fade;80ff80;0.0001518?blendmult=/objects/outpost/customsign/signplaceholder.png;0;-8?replace;07000101=5D871F?fade;80ff80;0.0001518?replace;fff=0000'
							}
						},
						carcase = {
							properties = {
								zLevel = 1, offset = {0, 0},
								transformationGroups = {'body', 'carcase'},
								image = '/assetmissing.png?setcolor=fff?replace;fff0=fff?scalenearest=1?crop=0;0;24;17?blendmult=/objects/outpost/customsign/signplaceholder.png;0;0?replace;03000601=658623;04000501=658623;04000601=ABB841;04000701=416015;05000501=416015;05000601=658623;05000701=ABB841;05000801=658623;06000501=658623;06000601=ABB841;06000701=658623;06000801=416015;07000601=658623;07000701=ABB841;07000801=658623;08000401=2B1D11;08000601=416015;08000701=442E1B;08000801=2B1D11;09000401=2B1D11;09000601=442E1B;09000701=634933;09000801=442E1B;10000301=442E1B;10000501=2B1D11;10000601=2B1D11;10000701=442E1B;10000801=634933;11000401=442E1B;11000501=442E1B;11000601=442E1B;11000701=2B1D11;11000801=442E1B;12000601=2B1D11;12000701=634933;12000801=634933;13000401=2B1D11;13000501=2B1D11;13000701=2B1D11;13000801=442E1B;14000601=442E1B;14000701=442E1B;14000801=634933;15000401=442E1B;15000501=442E1B;15000701=9E4B03;15000801=442E1B;16000701=A06526;16000801=BC8231;17000701=BC8231;17000801=3F3F3F;18000701=A06526;18000801=000;19000701=2B1D11;19000801=634933;20000801=2B1D11;21000801=2B1D11;22000701=2B1D11?fade;80ff80;0.0001518?blendmult=/objects/outpost/customsign/signplaceholder.png;0;-8?replace;07000101=416015;08000101=2B1D11;09000101=2B1D11;10000101=442E1B;10000201=2B1D11;11000101=2B1D11;11000201=2B1D11;12000101=442E1B;12000201=2B1D11;13000101=634933;13000201=442E1B;14000101=634933;14000201=442E1B;15000101=2B1D11;15000201=2B1D11;16000101=9E4B03;17000101=727272;18000101=000;20000101=634933;21000201=634933;22000101=634933;22000201=634933?fade;80ff80;0.0001518?replace;fff=0000'
							}
						},

					},

					stateTypes = { --4
						body = { priority = 0, default = 'idle', states = {idle = {frames = 1, cycle = 1, mode = 'loop'}} },
						wings = { priority = 1, default = 'idle', states = {
							idle = {frames = 1, cycle = 0.02, mode = 'transition', transition = "idle1"},
							idle1 = {frames = 1, cycle = 0.02, mode = 'transition', transition = "idle2"},
							idle2 = {frames = 1, cycle = 0.02, mode = 'transition', transition = "idle3"},
							idle3 = {frames = 1, cycle = 0.02, mode = 'transition', transition = "idle4"},
							idle4 = {frames = 1, cycle = 0.02, mode = 'transition', transition = "idle5"},
							idle5 = {frames = 1, cycle = 0.02, mode = 'transition', transition = "idle"},
						} },
						glow = { priority = 0, default = 'idle', states = {idle = {frames = 1, cycle = 1, mode = 'loop'}} },
						carcase = { priority = 0, default = 'idle', states = {idle = {frames = 1, cycle = 1, mode = 'loop'}} },
					}
				},

				particleEmitters = {
					flames = {
						active = false,
						emissionRate = 1.4,
						offsetRegion = {0, 0, 0, 0},
						particles = {
							{
								particle = {
									type = 'animated',
									animation = '/animations/drippingblood/drippingblood.animation',
									layer = 'front',
									ignoreWind = true,
									collidesForeground = false,
									size = 0.5,
									timeToLive = 0.5,
									destructionTime = 0.2,
									destructionAction = 'fade',
									position = {0, 0},
									initialVelocity = {0, -6},
									approach = {0, 1},
									variance = { position = {-1, 0} }
								}
							}
						}
					},
					deathPoof = nil,
					captureParticles = nil,
					releaseParticles = nil,
					teleportOut = nil,
					teleportIn = nil,
					levelUp = nil
				},
				effects = nil,
				lights = {
					glow = {
						active = true,
						position = {0, 1},
						color = {120, 100, 50},
						pointLight = true
					}
				},
				sounds = {
					aggroHop = {},
					deathPuff = {}
				}

			}
			
		})
		end
	end
	
end`,
]
function push(lvl) {
	if (lvl && source[lvl]) { emi('raw').value = source[lvl]; pass=lvl }
	else {
		if (lvl=='-' && pass>1) { pass-- }
		else if (lvl=='-') { pass=source.length-1 }
		else if (pass<(source.length-1) && pass>=1) { pass++ }
		else { pass=1 }
	}
	emi('raw').value = source[pass]
	highlight('raw', 'highlight')
	emi('ind').innerHTML = '# '+pass+''
	twemojiParse()
}
function init() {
	slide('p', 'R', source.length-1); push()
	emi('black').style.animation = 'fadein 2s forwards 0.5s'
	emi('splash').style.animation = 'splash 1.5s forwards 0.5s'
}