--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

include( "shared.lua" )

function GM:FlItemRespawnTime( pItem )
  return -1
end

function GM:ItemShouldRespawn( pItem )
  return 6 -- GR_ITEM_RESPAWN_NO
end

function GM:PlayerSpawn( pPlayer )
	return false
end
