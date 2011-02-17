--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Dumps a list of globals in _G in wiki format for Sandpedia.
--
--===========================================================================--

local globals = {}
local br = "<br>"

-- Andrew; dump the globals, purge the enumerations, we'll deal with that in a
-- separate article.
for global, v in pairs( _G ) do
  if ( type( v ) ~= "number" and type( v ) ~= "table" ) then
    table.insert( globals, global )
  end
end

table.sort( globals )

-- Andrew; just remove any shared globals and put them in Shared:Globals
for i, global in pairs( globals ) do
  if ( i == #globals ) then
    br = ""
  end
  print( "*[[_G." .. global .. "|" .. global .. "]]" .. br )
end
