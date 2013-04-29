--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

include( "shared.lua" )

local tSpawnPointClassnames = {
  "info_player_deathmatch",
  "info_player_combine",
  "info_player_rebel",
  "info_player_terrorist",
  "info_player_counterterrorist",
  "info_player_axis",
  "info_player_allies",
  "info_player_start"
}

function GM:FlItemRespawnTime( pItem )
  return -1
end

function GM:GiveDefaultItems( pPlayer )
  pPlayer:GiveNamedItem( "weapon_physgun" )
  self.BaseClass:GiveDefaultItems( pPlayer )
end

function GM:ItemShouldRespawn( pItem )
  return 6
end

function GM:PlayerEntSelectSpawnPoint( pHL2MPPlayer )
  local tSpawnPoints = {}
  local pSpot = NULL
  for _, classname in ipairs( tSpawnPointClassnames ) do
    pSpot = gEntList.FindEntityByClassname( NULL, classname )
    while ( pSpot ~= NULL ) do
      table.insert( tSpawnPoints, pSpot )
      pSpot = gEntList.FindEntityByClassname( pSpot, classname )
    end
  end
  return tSpawnPoints[ math.random( 1, #tSpawnPoints ) ]
end

function GM:PlayerPickupObject( pHL2MPPlayer, pObject, bLimitMassAndSize )
end
