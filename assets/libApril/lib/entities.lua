User.set.entities = function()
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
	
end