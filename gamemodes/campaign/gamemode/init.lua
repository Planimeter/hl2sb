--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

local UTIL_SetOrigin = UTIL.SetOrigin
local UTIL_SetSize = UTIL.SetSize
local UTIL_EntitiesInSphere = UTIL.EntitiesInSphere
local MAX_SPHERE_QUERY = 256
local MAX_WEAPONS = 48

include( "shared.lua" )

function GM:FlItemRespawnTime( pItem )
  return -1
end

function GM:GiveDefaultItems( pHL2MPPlayer )
end

function GM:ItemShouldRespawn( pItem )
  return 6 -- GR_ITEM_RESPAWN_NO
end

function GM:LevelInit( strMapName, strMapEntities, strOldLevel, strLandmarkName, loadGame, background )
  gpGlobals.mapname = strMapName
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
      pTrigger:SetAbsOrigin( vecOrigin )
      pTrigger.m_vecMins = vecMins
      pTrigger.m_vecMaxs = vecMaxs
      pTrigger.m_szMapName = pEntity.m_szMapName
      pTrigger.m_szLandmarkName = pEntity.m_szLandmarkName

      pTrigger:Spawn()

      -- Huh?
      if ( pTrigger.m_szMapName == gpGlobals.mapname ) then
        pTrigger:Remove()
      end
    end
    table.insert( tTriggers, pEntity )
    pEntity = gEntList.FindEntityByClassname( pEntity, "trigger_changelevel" )
  end

  for i, pTrigger in ipairs( tTriggers ) do
    pTrigger:Remove()
  end

  g_bChangeLevelReset = true
end

GM.m_tLoadout = {}
GM.m_tPickups = {}

function GM:PlayerInitialSpawn( pPlayer )
  if ( not g_bChangeLevelReset ) then
    self:ResetChangeLevel()
  end
  
  pPlayer.m_nUpdateLoadoutTime = gpGlobals.curtime() + 1

  hook.add( "PlayerThink", "PlayerInitialItemSpawn", function( pPlayer )
    if ( pPlayer:GetAbsOrigin() ~= vec3_origin ) then
      if ( pPlayer:GetPlayerLocalData().m_bWearingSuit ) then
        table.insert( self.m_tPickups, "item_suit" )
      end
      
      local _, list = UTIL_EntitiesInSphere( MAX_SPHERE_QUERY, pPlayer:GetAbsOrigin(), 128, 0 )
      for i, pEntity in ipairs( list ) do
        if ( pEntity:IsItem() ) then
          pEntity:Touch( pPlayer )
          table.insert( self.m_tPickups, pEntity:GetClassname() )
        end
      end
      hook.remove( "PlayerThink", "PlayerInitialItemSpawn" )
    end
  end )
end

function GM:PlayerSpawn( pPlayer )
  for _, classname in ipairs( self.m_tLoadout ) do
    pPlayer:GiveNamedItem( classname )
  end

  for _, classname in ipairs( self.m_tPickups ) do
    local pEntity = CreateEntityByName( classname )
    pEntity:SetAbsOrigin( pPlayer:GetAbsOrigin() )
    pEntity:Spawn()
    pEntity:Touch( pPlayer )
  end
  return false
end

function GM:PlayerPickupObject( pHL2MPPlayer, pObject, bLimitMassAndSize )
end

function GM:PlayerThink( pPlayer )
  if ( pPlayer.m_nUpdateLoadoutTime and pPlayer.m_nUpdateLoadoutTime <= gpGlobals.curtime() ) then
    for i = 0, MAX_WEAPONS - 1 do
      local pWeapon = pPlayer:GetWeapon(i);
      if ( tostring( pWeapon ) ~= "NULL" ) then
        table.insert( self.m_tLoadout, pWeapon:GetClassname() )
      end
    end

    pPlayer.m_nUpdateLoadoutTime = nil
  end
end
