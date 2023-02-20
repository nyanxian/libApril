User.set.playerdata = function()
playerdata = {
	hair = {
		[0] = '?replace;D9C189=FFF;A38D59=bbb;735E3A=777',
		'',
	},
	
	emote = {  [0]='',
		'',
	},
	
	cloth = {
		[0] = {
			head = {
				name = 'winterscarfhead', count = 1, parameters = { shortdescription='', description='',  rarity='common',
					directives='?replace;FFCA8A=fff0;E0975C=fff0;A85636=fff0;6F2919=fff0;000000=fff0',
					inventoryIcon='/assetmissing.png', category='', maxStack=1, price=0, tooltipFields={rarityLabel='', priceLabel=''}
				}
			},
			chest = {
				name = 'tshirtchest', count = 1, parameters = { shortdescription='', description='',  rarity='common',
					directives='?replace;FFCA8A=fff0;E0975C=fff0;A85636=fff0;6F2919=fff0;000000=fff0',
					inventoryIcon='/assetmissing.png', category='', maxStack=1, price=0, tooltipFields={rarityLabel='', priceLabel=''}
				}
			},
			legs = {
				name = 'aviancommonerlegs', count = 1, parameters = { shortdescription='', description='',  rarity='common',
					directives='?replace;FFCA8A=fff0;E0975C=fff0;A85636=fff0;6F2919=fff0;000000=fff0',
					inventoryIcon='/assetmissing.png', category='', maxStack=1, price=0, tooltipFields={rarityLabel='', priceLabel=''}
				}
			},
		},
		{
			chest = {
				name = 'aviantier6schest', count = 1, parameters = {
					shortdescription = 'Template', category = '', description = '',
					tooltipFields = {rarityLabel='', priceLabel=''},
					rarity = 'Essential', price = 0, leveledStatusEffects = jarray(),
					inventoryIcon = 'fsleeve.png:idle.1',
					dynamic = true, portraitProtected = true,
					directives = '',
					dynamicData = {
						base = '',
						moving = ''
					}
				}
			},
		},
		
	},
	
}
	
	characters = {
		none = { hair = 0, emote = 0, cloth = 0 },
		
	}
	
	--ex: playerset('hair', 1)
	playerget = function(category, ind)
		if category=='hair' and playerdata.hair[ind] then
			plr('setHairDirectives', '')
			plr('setHairDirectives', playerdata.hair[ind])
		end
		if category=='emote' and playerdata.emote[ind] then
			plr('setEmoteDirectives', '')
			plr('setEmoteDirectives', playerdata.emote[ind])
		end
		if category=='cloth' and playerdata.cloth[ind] then
			if playerdata.cloth[ind].head then
				plr('setEquippedItem', 'headCosmetic', playerdata.cloth[ind].head)
			end
			if playerdata.cloth[ind].chest then
				plr('setEquippedItem', 'chestCosmetic', playerdata.cloth[ind].chest)
			end
			if playerdata.cloth[ind].legs then
				plr('setEquippedItem', 'legsCosmetic', playerdata.cloth[ind].legs)
			end
			if playerdata.cloth[ind].back then
				plr('setEquippedItem', 'backCosmetic', playerdata.cloth[ind].back)
			end
		end
	end
	
	playerset = function(name)
		plr('setName', name)
		if name=='none' then plr('setName', root_username) end
		if characters[name] then
			for i, v in pairs(characters[name]) do
				if playerdata[i] and playerdata[i][v] then playerget(i, v) end
			end
		end
	end
	
end