--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

include( "shared.lua" )

function GM:FlItemRespawnTime( pItem )
  return 0xFFFFFFFF
end

function GM:GiveDefaultItems( pPlayer )
  pPlayer:GiveNamedItem( "weapon_physgun" )
end
