--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

include( "shared.lua" )

function GM:Host_Say( pPlayer, p, teamonly )
end

function GM:LevelInit( strMapName, strMapEntities, strOldLevel, strLandmarkName, loadGame, background )
end

function GM:CanPlayerHearPlayer( pListener, pTalker, bProximity )
end

function GM:FPlayerCanTakeDamage( pPlayer, pAttacker )
end

function GM:AllowDamage( pVictim, info )
end

function GM:PlayerThink( pPlayer )
end

function GM:PlayerSpawn( pPlayer )
end

function GM:FPlayerCanRespawn( pPlayer )
end

function GM:FlPlayerSpawnTime( pPlayer )
end

function GM:AddLevelDesignerPlacedObject( pEntity )
end

function GM:RemoveLevelDesignerPlacedObject( pEntity )
end

function GM:VecItemRespawnSpot( pItem )
end

function GM:VecItemRespawnAngles( pItem )
end

function GM:FlItemRespawnTime( pItem )
  return cvar.FindVar( "sv_hl2mp_item_respawn_time" ):GetFloat();
end

function GM:CanHavePlayerItem( pPlayer, pItem )
  if ( cvar.FindVar( "mp_weaponstay" ):GetInt() > 0 ) then
    if ( pPlayer:Weapon_OwnsThisType( pItem:GetClassname(), pItem:GetSubType() ) ) then
	  return false;
	end
  end
end

function GM:WeaponShouldRespawn( pWeapon )
end

function GM:ClientDisconnected( pClient )
end

function GM:FlPlayerFallDamage( pPlayer )
end

function GM:PlayerCanHearChat( pListener, pSpeaker )
end

function GM:ClientConnected( pEntity, pszName, pszAddress, reject, maxrejectlen )
end

function GM:InitHUD( pPlayer )
end

function GM:FShouldSwitchWeapon( pPlayer, pWeapon )
end

function GM:CheckChatForReadySignal( pPlayer, chatmsg )
end

function GM:GiveDefaultItems( pPlayer )
end

function GM:PlayerDeathThink( pPlayer )
end

function GM:CheatImpulseCommands( pPlayer, iImpulse )
end

function GM:PlayerDeathSound( info )
end

function GM:ShouldHideServer()
end

function GM:NetworkIDValidated( strUserName, strNetworkID )
end

function GM:RestartGame()
end

function GM:CleanUpMap()
end

function GM:PlayerInitialSpawn( pPlayer )
end
