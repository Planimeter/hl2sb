--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

include( "shared.lua" )

function GM:FlItemRespawnTime( pItem )
  return -1
end

function GM:GiveDefaultItems( pHL2MPPlayer )
end

function GM:ItemShouldRespawn( pItem )
  return 6 -- GR_ITEM_RESPAWN_NO
end

-- HACKHACK: This should be occurring when the gamemode, or more precisely the
-- level initializes. Until I can figure out what's going on, just reset the
-- level transitions on the first player's initial spawn.
local g_bChangeLevelReset = false

function GM:ResetChangeLevel()
  if ( g_bChangeLevelReset ) then
    return
  end

  local pEntity = gEntList.FindEntityByClassname( NULL, "trigger_changelevel" )
  local tTriggers = {}
  while ( pEntity ~= NULL ) do
    local pTrigger = CreateEntityByName( "trigger_changelevel_scripted" );
    if ( pTrigger ~= NULL ) then
      local vecMins = pEntity:WorldAlignMins()
      local vecMaxs = pEntity:WorldAlignMaxs()
      local vecOrigin = vecMaxs - ((vecMaxs - vecMins) / 2)
      UTIL.SetOrigin( pTrigger, vecOrigin );
      -- UTIL.SetSize( pTrigger, vecMins, vecMaxs );
      pTrigger.m_vecMins = vecMins
      pTrigger.m_vecMaxs = vecMaxs
      print( "pTrigger.m_vecMins: " .. tostring( pTrigger.m_vecMins ) )
      print( "pTrigger.m_vecMaxs: " .. tostring( pTrigger.m_vecMaxs ) )

      pTrigger:Spawn();
    end
    table.insert( tTriggers, pEntity )
    pEntity = gEntList.FindEntityByClassname( pEntity, "trigger_changelevel" )
  end

  for i, pTrigger in ipairs( tTriggers ) do
    pTrigger:Remove()
  end

  g_bChangeLevelReset = true
end

function GM:PlayerInitialSpawn( pPlayer )
  self:ResetChangeLevel()
end

function GM:PlayerPickupObject( pHL2MPPlayer, pObject, bLimitMassAndSize )
end
