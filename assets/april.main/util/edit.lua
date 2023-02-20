--[[ A list of non-direct utilities for Starbound.
Simply put or include it in your Lua compilator, or execute functions at the bottom and run the script separately. ]]

-- convert string to player uuid (must contain 32 characters)
function uuid(str32)
	if type(str32)=='string' and (str32:len()==32) then
		local regex = '[^aAbBcCdDeEfF1-9]'
		local str = str32:gsub(regex, '0', 32)
		print(str, str:len())
	end
end

-- convert json to lua (use multistring [[ ]])
function lua(str)
	local str = str: gsub(':', '='): gsub('" =', ' ='): gsub('"=', ' ='):
	gsub('[\[][\]]', 'jarray()'): gsub('[\[] [\]]', 'jarray()'): gsub('[\[]', '{'):
	gsub('[\]]', '}'): gsub('  "', '  '): gsub('  ', '	'): gsub('	"', '	'): gsub('"', "'")
	print(str)
end

--> EXECUTION SECTION <--


-- infinite loop to keep window alive (for Windows users)
while not window_close do end