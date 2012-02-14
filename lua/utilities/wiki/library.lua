--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Dumps an individual library in wiki format for Sandpedia.
--
--===========================================================================--

-- Andrew; set your desired library here, let the script do the rest.
local LIBRARY = "coroutine"

-- Make sure it's loaded!
local tLib = require( LIBRARY )

local fields = {}

for field, v in pairs( tLib ) do
  table.insert( fields, field )
end

table.sort( fields )

for i, field in pairs( fields ) do
  if ( i == #fields ) then
    br = ""
  end
  print( "*[[" .. LIBRARY .. "." .. field .. "]]" )
end
