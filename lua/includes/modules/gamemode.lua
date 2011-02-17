--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Gamemode handling.
--
--===========================================================================--

_BASE_GAMEMODE = "deathmatch"

require( "hook" )

local hook = hook
local table = table
local print = print
local _BASE_GAMEMODE = _BASE_GAMEMODE

module( "gamemode" )

local tGamemodes = {}

-------------------------------------------------------------------------------
-- Purpose: Calls a gamemode function
-- Input  : strEventName - Name of the internal GameRules method
-- Output :
-------------------------------------------------------------------------------
function Call( strEventName, ... )
  if ( GAMEMODE and GAMEMODE[ strEventName ] == nil ) then
    return false
  end
  return hook.Call( strEventName, GAMEMODE, ... )
end

-------------------------------------------------------------------------------
-- Purpose: Returns a gamemode table object
-- Input  : strName - Name of the gamemode
-- Output : table
-------------------------------------------------------------------------------
function Get( strName )
  return tGamemodes[ strName ]
end

-------------------------------------------------------------------------------
-- Purpose: Registers a gamemode
-- Input  : tGamemode - Gamemode table object
--			strName - Name of the gamemode
--			strBaseClass - Name of the base class
-- Output :
-------------------------------------------------------------------------------
function Register( tGamemode, strName, strBaseClass )
  if ( Get( strName ) ~= nil and GAMEMODE ~= nil ) then
    tGamemode = table.inherit( tGamemode, GAMEMODE )
  end
  if ( strName ~= _BASE_GAMEMODE ) then
	tGamemode = table.inherit( tGamemode, Get( strBaseClass ) )
  end
  tGamemodes[ strName ] = tGamemode
end
