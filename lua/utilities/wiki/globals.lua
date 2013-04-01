--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Dumps a list of globals in _G in wiki format for Sandpedia.
--
--===========================================================================--

-- List of globals in the Source Engine Lua API

local globals = {}

for global, v in pairs( _G ) do
  if ( type( v ) ~= "number" and type( v ) ~= "table" ) then
    table.insert( globals, global )
  end
end

table.sort( globals )

local file = assert( io.open( "globals.txt", "wb" ) )
for i, global in ipairs( globals ) do
  file:write( "*[[_G." .. global .. "|" .. global .. "]]\r\n" )
end
assert( io.close( file ) )
