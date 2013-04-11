--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Tests the KeyValues implementation.
--
--===========================================================================--

local function recursiveprintkeyvalues( kv, indent )
  indent = indent or 0

  local whitespace = ""
  for i = 1, indent do
    whitespace = whitespace .. "\t"
  end

  local t = kv:GetFirstSubKey();
  while t ~= NULL_KEYVALUES do
    local k, v = t:GetName(), t:GetString()
    print( whitespace .. k, v );
    recursiveprintkeyvalues( t, indent + 1 )
    t = t:GetNextKey();
  end
end

local gamePath
if _CLIENT then
  gamePath = engine.GetGameDirectory();
else
  gamePath = engine.GetGameDir();
end

local pMainFile = KeyValues( "gameinfo.txt" );
if ( pMainFile:LoadFromFile( gamePath .. "/gameinfo.txt", "MOD" ) ) then
  recursiveprintkeyvalues( pMainFile )
end
pMainFile:deleteThis();
