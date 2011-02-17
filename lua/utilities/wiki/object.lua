--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Dumps an individual object in wiki format for Sandpedia.
--
--===========================================================================--

-- Andrew; set your desired object here, let the script do the rest.
local OBJECT = "FILE*"

local fields = {}
local br = "<br>"

for field, v in pairs( _R[ OBJECT ] ) do
  table.insert( fields, field )
end

table.sort( fields )

for i, field in pairs( fields ) do
  if ( i == #fields ) then
    br = ""
  end
  print( "*[[" .. OBJECT .. "." .. field .. "]]" .. br )
end
