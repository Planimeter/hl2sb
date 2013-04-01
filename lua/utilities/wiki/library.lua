--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Dumps an individual library in wiki format for Sandpedia.
--
--===========================================================================--

local tLibraries = {}

for k, v in pairs( _G ) do
  -- Only print tables
  if ( type( v ) == "table" ) then
    table.insert( tLibraries, k )
  end
end

for _, LIBRARY in pairs( tLibraries ) do
  local fields = {}

  for field, _ in pairs( _G[ LIBRARY ] ) do
    table.insert( fields, field )
  end

  table.sort( fields )

  local file = assert( io.open( LIBRARY .. ".txt", "wb" ) )
  for i, field in pairs( fields ) do
    file:write( "*[[" .. LIBRARY .. "." .. field .. "]]\r\n" )
  end
  assert( io.close( file ) )
end
