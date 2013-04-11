--======== Copyleft © 2010-2013, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Tests the KeyValues implementation.
--
--===========================================================================--

local gamePath
if _CLIENT then
  gamePath = engine.GetGameDirectory();
else
  gamePath = engine.GetGameDir();
end

local pMainFile = KeyValues( "gameinfo.txt" );
if ( pMainFile:LoadFromFile( gamePath .. "/gameinfo.txt", "MOD" ) ) then
  print( "KeyValues: ")
  pMainFile:Print( 1 )

  print( "Table: ")
  table.print( pMainFile:ToTable(), 1 )
end
pMainFile:deleteThis();
