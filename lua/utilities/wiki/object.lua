--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Dumps an individual object in wiki format for Sandpedia.
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

for _, OBJECT in pairs( tMetatables ) do
  if ( OBJECT ~= "FILE*" ) then
    local fields = {}

    for field, _ in pairs( _R[ OBJECT ] ) do
      table.insert( fields, field )
    end

    table.sort( fields )

    local file = assert( io.open( OBJECT .. ".txt", "wb" ) )
    for i, field in pairs( fields ) do
      if ( i == #fields ) then
        br = ""
      end
      -- print( "*[[" .. OBJECT .. "." .. field .. "]]" )
      file:write( "*[[" .. OBJECT .. "." .. field .. "]]" .. "\r\n" )
    end
    assert( io.close( file ) )
  end
end
