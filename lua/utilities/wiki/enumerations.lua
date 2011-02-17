--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Dumps a list of enumerations in _G in wiki format for Sandpedia.
--
--===========================================================================--

local enumerations = {}
local br = "<br>"

for enumeration, n in pairs( _G ) do
  if ( type( n ) == "number" ) then
    table.insert( enumerations, enumeration )
  end
end

table.sort( enumerations )

-- Andrew; just remove any shared enumerations, put them in Shared:Enumerations
for i, enumeration in pairs( enumerations ) do
  if ( i == #enumerations ) then
    br = ""
  end
  print( "*[[_G." .. enumeration .. "|" .. enumeration .. "]]" .. br )
end
