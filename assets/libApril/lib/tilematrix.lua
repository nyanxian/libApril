User.set.tilematrix = function()
	-- container for scanned tiles
	tilematrix = { fg={}, bg={}, obj={} } -- {fg={ {name='tilename', pos={1, 1}} }}
	
	-- scan around following position: mouse [cur] or player [pos]
	tilematrix_scan = cur
	
	-- range in tiles (X x Y)
	tilematrix_maxXY = 4
	
	-- tile scan (+object)
	function tilescanBase()
		for y = -tilematrix_maxXY, tilematrix_maxXY do
			for x = -tilematrix_maxXY, tilematrix_maxXY do
				local xy = { tilematrix_scan[1]+x, tilematrix_scan[2]+y }
				local obj = world.objectQuery(xy, 0.9, {boundMode='position'})[1]
				table.insert(tilematrix.fg, { name=world.material(xy, 'foreground'), mod=world.mod(xy, 'foreground'), pos=xy })
				table.insert(tilematrix.bg, { name=world.material(xy, 'background'), mod=world.mod(xy, 'background'), pos=xy })
				if obj and type(obj)=='number' then -- cringe ass, returns [id] instead of table
					table.insert(tilematrix.obj, { name=world.entityName(obj), params={
					unbreakable=false, objectName=world.getObjectParameter(obj, "objectName"), objectType=world.getObjectParameter(obj, "objectType"),
					tooltipKind=world.getObjectParameter(obj, "tooltipKind"), category=world.getObjectParameter(obj, "category"),
					shortdescription=world.getObjectParameter(obj, "shortdescription"), description=world.getObjectParameter(obj, "description"),
					inventoryIcon=world.getObjectParameter(obj, "inventoryIcon"), color=world.getObjectParameter(obj, "color"),
					image=world.getObjectParameter(obj, "image"), largeImage=world.getObjectParameter(obj, "largeImage"),
					rarity=world.getObjectParameter(obj, "rarity"), price=world.getObjectParameter(obj, "price"),
					race=world.getObjectParameter(obj, "race"), printable=world.getObjectParameter(obj, "printable"),
					orientations=world.getObjectParameter(obj, "orientations"), animation=world.getObjectParameter(obj, "animation"),
					animationPosition=world.getObjectParameter(obj, "animationPosition"), animationParts=world.getObjectParameter(obj, "animationParts"),
					lightColor=world.getObjectParameter(obj, "lightColor"), stages=world.getObjectParameter(obj, "stages"),
					maxImmersion=world.getObjectParameter(obj, "maxImmersion"), scripts=world.getObjectParameter(obj, "scripts"),
					scriptDelta=world.getObjectParameter(obj, "scriptDelta"), health=world.getObjectParameter(obj, "health"),
					interactAction=world.getObjectParameter(obj, "interactAction"), interactData=world.getObjectParameter(obj, "interactData"),
					winningItem=world.getObjectParameter(obj, "winningItem"), rooting=world.getObjectParameter(obj, "rooting"),
					smashSounds=world.getObjectParameter(obj, "smashSounds"), smashParticles=world.getObjectParameter(obj, "smashParticles"),
					terraformOffset=world.getObjectParameter(obj, "terraformOffset"), terraformSize=world.getObjectParameter(obj, "terraformSize"),
					pregenerateTime=world.getObjectParameter(obj, "pregenerateTime"), terraformBiome=world.getObjectParameter(obj, "terraformBiome") }})
					else table.insert(tilematrix.obj, 'nil')
				end
				text(xy, '^#58f;x^reset;'); coroutine.yield()
			end
		end
	end
	
	-- tile place: foreground (+object)
	function tilebreakFgBase()
		for y = -tilematrix_maxXY, tilematrix_maxXY do
			for x = -tilematrix_maxXY, tilematrix_maxXY do
				local xy = { tilematrix_scan[1]+x, tilematrix_scan[2]+y }
				world.damageTileArea(xy, 0.8, 'foreground', xy, 'blockish', math.huge, 0)
				world.damageTileArea(xy, 0.8, 'foreground', xy, 'blockish', math.huge, 0)
				text(xy, '^#f55;-^reset;'); coroutine.yield()
			end
		end
	end
	function tileloadFgBase()
		for y = -tilematrix_maxXY, tilematrix_maxXY do
			for x = -tilematrix_maxXY, tilematrix_maxXY do
				local xy = { tilematrix_scan[1]+x, tilematrix_scan[2]+y }
				tilematrix_index = (tilematrix_index or 0)+1
				if tilematrix.fg[tilematrix_index] and type(tilematrix.fg[tilematrix_index])=='table' then
					if tilematrix.fg[tilematrix_index].name then world.placeMaterial(xy, 'foreground', tilematrix.fg[tilematrix_index].name, 0, true) end
					if tilematrix.fg[tilematrix_index].mod then world.placeMod(xy, 'foreground', tilematrix.fg[tilematrix_index].mod, 0, true) end
				end
				text(xy, '^#8f5;+^reset;'); coroutine.yield()
			end
		end
	end
	
	-- tile place: background
	function tilebreakBgBase()
		for y = -tilematrix_maxXY, tilematrix_maxXY do
			for x = -tilematrix_maxXY, tilematrix_maxXY do
				local xy = { tilematrix_scan[1]+x, tilematrix_scan[2]+y }
				world.damageTileArea(xy, 0.8, 'background', xy, 'blockish', math.huge, 0)
				world.damageTileArea(xy, 0.8, 'background', xy, 'blockish', math.huge, 0)
				text(xy, '^#f55;-^reset;'); coroutine.yield()
			end
		end
	end
	function tileloadBgBase()
		for y = -tilematrix_maxXY, tilematrix_maxXY do
			for x = -tilematrix_maxXY, tilematrix_maxXY do
				local xy = { tilematrix_scan[1]+x, tilematrix_scan[2]+y }
				tilematrix_index = (tilematrix_index or 0)+1
				if tilematrix.bg[tilematrix_index] and type(tilematrix.bg[tilematrix_index])=='table' then
					if tilematrix.bg[tilematrix_index].name then world.placeMaterial(xy, 'background', tilematrix.bg[tilematrix_index].name, 0, true) end
					if tilematrix.bg[tilematrix_index].mod then world.placeMod(xy, 'background', tilematrix.bg[tilematrix_index].mod, 0, true) end
				end
				if tilematrix.obj[tilematrix_index] and type(tilematrix.obj[tilematrix_index])=='table' then
					world.placeObject(tilematrix.obj[tilematrix_index].name, xy, math.random(0,1), tilematrix.obj[tilematrix_index].params)
				end
				text(xy, '^#8f5;+^reset;'); coroutine.yield()
			end
		end
	end
	
	-- wrapping into coroutines for safety in performance
	tilescan = coroutine.create(tilescanBase)
	tilebreakFg = coroutine.create(tilebreakFgBase)
	tileloadFg = coroutine.create(tileloadFgBase)
	tilebreakBg = coroutine.create(tilebreakBgBase)
	tileloadBg = coroutine.create(tileloadBgBase)
end

User.upd.tilematrix = function()
	--SquareBracketLeft: tile scan (+object)
	if sbl and (not tile_scanning) then tile_scanning = true; tilematrix = { fg={}, bg={}, obj={} } end
	if tile_scanning then stun(); stunned=true
		coroutine.resume(tilescan)
		if coroutine.status(tilescan)=='dead' then
			tilescan = coroutine.create(tilescanBase)
			tile_scanning=false; stunned=false
		end
	end
	
	--SquareBracketRight: tile load (breakFg->loadFg->breakBg->loadBg and loadObj)
	if sbr and not tile_loading then tile_loading = true end
	if tile_loading then stun(); stunned=true
		coroutine.resume(tilebreakFg)
		if coroutine.status(tilebreakFg)=='dead' then
			coroutine.resume(tileloadFg)
			if coroutine.status(tileloadFg)=='dead' then
				if tilematrix_index >= #tilematrix.fg then tilematrix_index = 0 end
				coroutine.resume(tilebreakBg)
				if coroutine.status(tilebreakBg)=='dead' then
					coroutine.resume(tileloadBg)
					if coroutine.status(tileloadBg)=='dead' then
						tilebreakFg = coroutine.create(tilebreakFgBase)
						tileloadFg = coroutine.create(tileloadFgBase)
						tilebreakBg = coroutine.create(tilebreakBgBase)
						tileloadBg = coroutine.create(tileloadBgBase)
						tile_loading=false; stunned=false
					end
				end
			end
		end
	end
	
	tilematrix_scan = cur
end