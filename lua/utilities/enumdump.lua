--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Dumps a list of all enumeration libraries in _E
--
--===========================================================================--

local dump = {}

local function swapcopy( t )
  local __copy = {}
	for k, v in pairs( t ) do
		__copy[ tostring( v ) ] = k
		print( "__copy[ " .. tostring( v ) .. " ] = " .. k )
	end
	return __copy
end

for name, lib in pairs( _E ) do
	print( "_E." .. name .. ": " .. tostring( lib ) )
	dump = swapcopy( lib )
	table.sort( dump, function( a, b ) return dump[ a ] < dump[ b ] end )
	for v, enum in pairs( dump ) do
		print( "  _E." .. name .. "." .. enum .. ": " .. v )
	end
end
