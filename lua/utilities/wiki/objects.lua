--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Dumps a list of all metatables in _R in wiki format for Sandpedia.
--
--===========================================================================--

-- Test to see if every metatable is actually a metatable, keep in mind that
-- this can be faked in two shakes of a lamb's tail
local tMetatables = {}
local br = "<br>"

for k, v in pairs( _R ) do
  -- Only print tables, everything else in _R should be a ref count
  if ( type( k ) ~= "number" and type( v ) == "table" ) then
    if ( v.__index ~= nil ) then
      table.insert( tMetatables, k )
    end
  end
end

table.sort( tMetatables )
for i, metatable in pairs( tMetatables ) do
  if ( i == #tMetatables ) then
    br = ""
  end
  print( "*[[" .. metatable .. "]]" .. br )
end
