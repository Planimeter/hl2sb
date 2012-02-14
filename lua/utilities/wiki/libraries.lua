--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Dumps a list of libraries in _G in wiki format for Sandpedia.
--
--===========================================================================--

-- Andrew; For page "List of libraries in Half-Life 2: Sandbox"

local blacklist = {
  -- HL2:SB table objects
  "_GAMEMODE",
  -- HL2:SB registry pseudo-index
  "_R",

  -- Andrew; We'll actually list these, except manually in Shared:Libraries
  -- LuaJIT Libraries
  "bit",
  "jit",

  -- Lua global pseudo-index
  "_G",

  -- Lua Standard Libraries
  "coroutine",
  "table",
  "io",
  "os",
  "string",
  "math",
  "debug",
  "package"
}

local bBlacklisted = false
local libraries = {}
local br = "<br>"

for library, t in pairs( _G ) do
  for _, v in pairs( blacklist ) do
    if ( library == v ) then
	  bBlacklisted = true
	end
  end
  if ( not bBlacklisted and type( t ) == "table" ) then
    table.insert( libraries, library )
  end
  bBlacklisted = false
end

table.sort( libraries )

-- Andrew; just remove any shared libraries, put them in Shared:Libraries
local file = assert( io.open( "libraries.txt", "wb") )
for i, library in pairs( libraries ) do
  if ( i == #libraries ) then
    br = ""
  end
  -- print( "*[[" .. library .. "]]" .. br )
  file:write( "*[[" .. library .. "]]" .. br .. "\r\n" )
end
assert( io.close( file ) )
