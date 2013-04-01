--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Dumps an individual class in wiki format for Sandpedia.
--
--===========================================================================--

local tMetatables = {}

for k, v in pairs( _R ) do
  -- Only print tables, everything else in _R should be a ref count
  if ( type( k ) ~= "number" and type( v ) == "table" ) then
    if ( v.__index ~= nil ) then
      table.insert( tMetatables, k )
    end
  end
end

for _, CLASS in pairs( tMetatables ) do
  if ( CLASS ~= "FILE*" ) then
    local fields = {}

    for field, _ in pairs( _R[ CLASS ] ) do
      table.insert( fields, field )
    end

    table.sort( fields )

    local file = assert( io.open( CLASS .. ".txt", "wb" ) )
    for i, field in pairs( fields ) do
      file:write( "*[[" .. CLASS .. "." .. field .. "]]\r\n" )
    end
    assert( io.close( file ) )
  end
end
