--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

GM.Name			= "Sandbox"
GM.Homepage		= "http://www.half-life2sandbox.com/"
GM.Developer	= "Team Sandbox"
GM.Manual		= "http://www.half-life2sandbox.com/manual"

function GM:Initialize()
if ( not _CLIENT ) then
  engine.ServerCommand( "mp_falldamage 1\n" )
  engine.ServerCommand( "mp_flashlight 1\n" )
end
end

function GM:FlWeaponRespawnTime( pWeapon )
  return 0xFFFFFFFF
end
