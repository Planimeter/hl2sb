--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

include( "shared.lua" )

local PLAYER_SOUNDS_CITIZEN = 0
local PLAYER_SOUNDS_COMBINESOLDIER = 1
local PLAYER_SOUNDS_METROPOLICE = 2

function GM:AddLevelDesignerPlacedObject( pEntity )
end

function GM:AllowDamage( pVictim, info )
end

function GM:CanEnterVehicle( pPlayer, pVehicle, nRole )
end

function GM:CanHavePlayerItem( pPlayer, pItem )
  if ( cvar.FindVar( "mp_weaponstay" ):GetInt() > 0 ) then
    if ( pPlayer:Weapon_OwnsThisType( pItem:GetClassname(), pItem:GetSubType() ) ) then
	  return false;
	end
  end
end

function GM:CanPlayerHearPlayer( pListener, pTalker, bProximity )
end

function GM:CheatImpulseCommands( pPlayer, iImpulse )
end

function GM:CheckChatForReadySignal( pPlayer, chatmsg )
end

function GM:CleanUpMap()
end

function GM:ClientConnected( pEntity, pszName, pszAddress, reject, maxrejectlen )
end

function GM:ClientDisconnected( pClient )
end

function GM:FlItemRespawnTime( pItem )
  return cvar.FindVar( "sv_hl2mp_item_respawn_time" ):GetFloat();
end

function GM:FlPlayerFallDamage( pPlayer )
end

function GM:FlPlayerSpawnTime( pPlayer )
end

function GM:FPlayerCanRespawn( pPlayer )
end

function GM:FPlayerCanTakeDamage( pPlayer, pAttacker )
end

function GM:FShouldSwitchWeapon( pPlayer, pWeapon )
end

function GM:GiveDefaultItems( pPlayer )
	self:EquipSuit();

	_R.CBasePlayer.GiveAmmo( self, 255,	"Pistol");
	_R.CBasePlayer.GiveAmmo( self, 45,	"SMG1");
	_R.CBasePlayer.GiveAmmo( self, 1,	"grenade" );
	_R.CBasePlayer.GiveAmmo( self, 6,	"Buckshot");
	_R.CBasePlayer.GiveAmmo( self, 6,	"357" );

	if ( self:GetPlayerModelType() == PLAYER_SOUNDS_METROPOLICE or self:GetPlayerModelType() == PLAYER_SOUNDS_COMBINESOLDIER ) then
		self:GiveNamedItem( "weapon_stunstick" );
	elseif ( self:GetPlayerModelType() == PLAYER_SOUNDS_CITIZEN ) then
		self:GiveNamedItem( "weapon_crowbar" );
	end
	
	self:GiveNamedItem( "weapon_pistol" );
	self:GiveNamedItem( "weapon_smg1" );
	self:GiveNamedItem( "weapon_frag" );
	self:GiveNamedItem( "weapon_physcannon" );

	local szDefaultWeaponName = engine.GetClientConVarValue( engine.IndexOfEdict( self ), "cl_defaultweapon" );

	local pDefaultWeapon = self:Weapon_OwnsThisType( szDefaultWeaponName );

	if ( pDefaultWeapon ~= NULL ) then
		self:Weapon_Switch( pDefaultWeapon );
	else
		self:Weapon_Switch( self:Weapon_OwnsThisType( "weapon_physcannon" ) );
	end
end

function GM:Host_Say( pPlayer, p, teamonly )
end

function GM:InitHUD( pPlayer )
end

function GM:ItemShouldRespawn( pItem )
end

function GM:LevelInit( strMapName, strMapEntities, strOldLevel, strLandmarkName, loadGame, background )
end

function GM:NetworkIDValidated( strUserName, strNetworkID )
end

function GM:PlayerCanHearChat( pListener, pSpeaker )
end

function GM:PlayerDeathSound( info )
end

function GM:PlayerDeathThink( pPlayer )
end

function GM:PlayerInitialSpawn( pPlayer )
end

function GM:PlayerSpawn( pPlayer )
end

function GM:PlayerThink( pPlayer )
end

function GM:RemoveLevelDesignerPlacedObject( pEntity )
end

function GM:RestartGame()
end

function GM:ShouldHideServer()
end

function GM:VecItemRespawnSpot( pItem )
end

function GM:VecItemRespawnAngles( pItem )
end

function GM:WeaponShouldRespawn( pWeapon )
end

function GM:Weapon_Equip( pPlayer, pWeapon )
end
