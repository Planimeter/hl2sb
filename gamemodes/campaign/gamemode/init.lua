--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

include( "shared.lua" )

function GM:FlItemRespawnTime( hItem )
  return -1
end

function GM:GiveDefaultItems( hHL2MPPlayer )
end

function GM:ItemShouldRespawn( hItem )
  return 6 -- GR_ITEM_RESPAWN_NO
end

function GM:PlayerSpawn( hPlayer )
	return false
end
