--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

GM.Name			= "Half-Life 2"
GM.Homepage		= "http://www.half-life2.com"
GM.Developer	= "Valve"
GM.Manual		= "http://www.half-life2.com/manual/HL2_quickrefcard.pdf?l=english&cc=US&os=windows"

function GM:Initialize()
if ( not CLIENT_LUA ) then
  engine.ServerCommand( "mp_falldamage 1\n" )
  engine.ServerCommand( "mp_flashlight 1\n" )
end
end

function GM:FlWeaponRespawnTime( pWeapon )
  return 0xFFFFFFFF
end
