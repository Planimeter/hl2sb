--========= Copyright © 1996-2005, Valve Corporation, All rights reserved. ============--
--
-- Purpose: 
--
--=============================================================================--

-- Crossbow

-- Weapon data is loaded by both the Game and Client DLLs.
SWEP.printname		= "#HL2_Crossbow"
SWEP.viewmodel		= "models/weapons/v_crossbow.mdl"
SWEP.playermodel	= "models/weapons/w_crossbow.mdl"
SWEP.anim_prefix	= "bow"
SWEP.bucket			= 3
SWEP.bucket_position	= 1

SWEP.clip_size		= 1
SWEP.default_clip		= 5
SWEP.primary_ammo		= "XBowBolt"
SWEP.secondary_ammo	= "None"

SWEP.weight		= 6
SWEP.item_flags		= 0

SWEP.damage		= 100

-- Sounds for the weapon. There is a max of 16 sounds per category (i.e. max 16 "single_shot" sounds)
SWEP.SoundData =
{
	single_shot	= "Weapon_Crossbow.Single",
	reload	= "Weapon_Crossbow.Reload",
	special1	= "Weapon_Crossbow.BoltElectrify",
	special2	= "Weapon_Crossbow.BoltFly"
}

if ( not bit ) then
	require( "bit" )
end

local band = bit.band
local VectorAngles = mathlib.VectorAngles

--local BOLT_MODEL			= "models/crossbow_bolt.mdl"
local BOLT_MODEL	= "models/weapons/w_missile_closed.mdl"

local BOLT_AIR_VELOCITY	= 3500
local BOLT_WATER_VELOCITY	= 1500
local	BOLT_SKIN_NORMAL	= 0
local BOLT_SKIN_GLOW		= 1


local BoltCreate

if not _CLIENT then

BoltCreate = function( vecOrigin, angAngles, iDamage, pentOwner )
	-- Create a new entity with CCrossbowBolt private data
	local pBolt = CreateEntityByName( "crossbow_bolt" );
	UTIL.SetOrigin( pBolt, vecOrigin );
	pBolt:SetAbsAngles( angAngles );
	pBolt:Spawn();
	pBolt:SetOwnerEntity( pentOwner );

	pBolt.m_iDamage = iDamage;

	return pBolt;
end

end

-------------------------------------------------------------------------------
-- SWeaponCrossbow
-------------------------------------------------------------------------------

SWEP.m_acttable = 
{
	{ 1048, 1026, false },
	{ 1049, 1028, false },

	{ 1058, 1027, false },
	{ 1061, 1029, false },

	{ 1073, 1030, false },
	{ 1077, 1030, false },

	{ 1090, 1030, false },
	{ 1093, 1030, false },

	{ 1064, 1032, false },
};

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function SWEP:Initialize()
	self.m_bReloadsSingly	= true;
	self.m_bFiresUnderwater	= true;
	self.m_bInZoom			= false;
	self.m_bMustReload		= false;
end

local	CROSSBOW_GLOW_SPRITE	= "sprites/light_glow02_noz.vmt"
local	CROSSBOW_GLOW_SPRITE2	= "sprites/blueflare1.vmt"

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function SWEP:Precache()
if not _CLIENT then
	UTIL.PrecacheOther( "crossbow_bolt" );
end

	_R.CBaseEntity.PrecacheScriptSound( "Weapon_Crossbow.BoltHitBody" );
	_R.CBaseEntity.PrecacheScriptSound( "Weapon_Crossbow.BoltHitWorld" );
	_R.CBaseEntity.PrecacheScriptSound( "Weapon_Crossbow.BoltSkewer" );

	_R.CBaseEntity.PrecacheModel( CROSSBOW_GLOW_SPRITE );
	_R.CBaseEntity.PrecacheModel( CROSSBOW_GLOW_SPRITE2 );

	self.BaseClass:Precache();
end

-------------------------------------------------------------------------------
-- Purpose:
-------------------------------------------------------------------------------
function SWEP:PrimaryAttack()
	if ( self.m_bInZoom and g_pGameRules.IsMultiplayer() ) then
--		self:FireSniperBolt();
		self:FireBolt();
	else
		self:FireBolt();
	end

	-- Signal a reload
	self.m_bMustReload = true;

	self:SetWeaponIdleTime( gpGlobals.curtime() + self:SequenceDuration( 180 ) );
end

-------------------------------------------------------------------------------
-- Purpose:
-------------------------------------------------------------------------------
function SWEP:SecondaryAttack()
	--NOTENOTE: The zooming is handled by the post/busy frames
end

-------------------------------------------------------------------------------
-- Purpose: 
-- Output : Returns true on success, false on failure.
-------------------------------------------------------------------------------
function SWEP:Reload()
if false then
	if ( self.BaseClass:Reload() ) then
		self.m_bMustReload = false;
		return true;
	end

	return false;
else
	self.m_bMustReload = false;

	local flSequenceEndTime = gpGlobals.curtime() + self:SequenceDuration( 132 );
	self:GetOwner():SetNextAttack( flSequenceEndTime );
	self.m_flNextPrimaryAttack = flSequenceEndTime;
	self.m_flNextSecondaryAttack = flSequenceEndTime;
end
end

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function SWEP:CheckZoomToggle()
	local pPlayer = ToBasePlayer( self:GetOwner() );
	
	if ( band( pPlayer.m_afButtonPressed, 2^11 ) ~= 0 ) then
		self:ToggleZoom();
	end
end

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function SWEP:ItemBusyFrame()
	-- Allow zoom toggling even when we're reloading
	self:CheckZoomToggle();
end

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function SWEP:ItemPostFrame()
	-- Allow zoom toggling
	self:CheckZoomToggle();

	if ( self.m_bMustReload and self:HasWeaponIdleTimeElapsed() ) then
		--self:Reload();
	end

	self.BaseClass:ItemPostFrame();
end

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function SWEP:FireBolt()
	if ( self.m_iClip1 <= 0 ) then
		if ( not self.m_bFireOnEmpty ) then
			self:Reload();
		else
			self:WeaponSound( 0 );
			self.m_flNextPrimaryAttack = 0.15;
		end

		return;
	end

	local pOwner = ToBasePlayer( self:GetOwner() );
	
	if ( pOwner == NULL ) then
		return;
	end

if not _CLIENT then
	local vecAiming	= pOwner:GetAutoaimVector( 0 );	
	local vecSrc		= pOwner:Weapon_ShootPosition();

	local angAiming = QAngle();
	VectorAngles( vecAiming, angAiming );

	--FIXME: add CBaseCombatWeapon:GetHL2MPWpnData()!!
	--local pBolt = BoltCreate( vecSrc, angAiming, self:GetHL2MPWpnData().m_iPlayerDamage, pOwner );
	local pBolt = BoltCreate( vecSrc, angAiming, self.damage, pOwner );

	if ( pOwner:GetWaterLevel() == 3 ) then
		pBolt:SetAbsVelocity( vecAiming * BOLT_WATER_VELOCITY );
	else
		pBolt:SetAbsVelocity( vecAiming * BOLT_AIR_VELOCITY );
	end

end

	self.m_iClip1 = self.m_iClip1 - 1;

	pOwner:ViewPunch( QAngle( -2, 0, 0 ) );

	self:WeaponSound( 1 );
	self:WeaponSound( 12 );

	self:SendWeaponAnim( 180 );

	if ( self.m_iClip1 == 0 and pOwner:GetAmmoCount( self.m_iPrimaryAmmoType ) <= 0 ) then
		-- HEV suit - indicate out of ammo condition
		pOwner:SetSuitUpdate("!HEV_AMO0", 0, 0);
	end

	self.m_flNextPrimaryAttack	= gpGlobals.curtime() + 0.75;
	self.m_flNextSecondaryAttack	= gpGlobals.curtime() + 0.75;

	self:DoLoadEffect();
	self:SetChargerState( CHARGER_STATE_DISCHARGE );
end

-------------------------------------------------------------------------------
-- Purpose: 
-- Output : Returns true on success, false on failure.
-------------------------------------------------------------------------------
function SWEP:Deploy()
	if ( self.m_iClip1 <= 0 ) then
		return self:DefaultDeploy( self:GetViewModel(), self:GetWorldModel(), 467, self:GetAnimPrefix() );
	end

	self:SetSkin( BOLT_SKIN_GLOW );

	return self.BaseClass:Deploy();
end

-------------------------------------------------------------------------------
-- Purpose: 
-- Input  : *pSwitchingTo - 
-- Output : Returns true on success, false on failure.
-------------------------------------------------------------------------------
function SWEP:Holster( pSwitchingTo )
	if ( self.m_bInZoom ) then
		self:ToggleZoom();
	end

	self:SetChargerState( CHARGER_STATE_OFF );

	return self.BaseClass:Holster( pSwitchingTo );
end

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function SWEP:ToggleZoom()
	local pPlayer = ToBasePlayer( self:GetOwner() );
	
	if ( pPlayer == NULL ) then
		return;
	end

if not _CLIENT then

	if ( self.m_bInZoom ) then
		if ( pPlayer:SetFOV( self, 0, 0.2 ) ) then
			self.m_bInZoom = false;
		end
	else
		if ( pPlayer:SetFOV( self, 20, 0.1 ) ) then
			self.m_bInZoom = true;
		end
	end
end
end

local	BOLT_TIP_ATTACHMENT	= 2

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function SWEP:CreateChargerEffects()
if not _CLIENT then
	local pOwner = ToBasePlayer( self:GetOwner() );

	if ( self.m_hChargerSprite ~= NULL ) then
		return;
	end

	self.m_hChargerSprite = _R.CSprite.SpriteCreate( CROSSBOW_GLOW_SPRITE, self:GetAbsOrigin(), false );

	if ( self.m_hChargerSprite ) then
		self.m_hChargerSprite:SetAttachment( pOwner:GetViewModel(), BOLT_TIP_ATTACHMENT );
		self.m_hChargerSprite:SetTransparency( kRenderTransAdd, 255, 128, 0, 255, kRenderFxNoDissipation );
		self.m_hChargerSprite:SetBrightness( 0 );
		self.m_hChargerSprite:SetScale( 0.1 );
		self.m_hChargerSprite:TurnOff();
	end
end
end

-------------------------------------------------------------------------------
-- Purpose: 
-- Input  : skinNum - 
-------------------------------------------------------------------------------
function SWEP:SetSkin( skinNum )
	local pOwner = ToBasePlayer( self:GetOwner() );
	
	if ( pOwner == NULL ) then
		return;
	end

	local pViewModel = pOwner:GetViewModel();

	if ( pViewModel == NULL ) then
		return;
	end

	pViewModel.m_nSkin = skinNum;
end

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function SWEP:DoLoadEffect()
	self:SetSkin( BOLT_SKIN_GLOW );

	local pOwner = ToBasePlayer( self:GetOwner() );

	if ( pOwner == NULL ) then
		return;
	end

	--Tony; change this up a bit; on the server, dispatch an effect but don't send it to the client who fires
	--on the client, create an effect either in the view model, or on the world model if first person.
	local data	= CEffectData();

	data.m_nAttachmentIndex = 1;

if _GAME then
	data.m_nEntIndex = self:entindex();

	local filter = CPASFilter( data.m_vOrigin );
	filter:RemoveRecipient( pOwner );
	--FIXME: add te library!!
	--te.DispatchEffect( filter, 0.0, data.m_vOrigin, "CrossbowLoad", data );
else
	local pViewModel = pOwner:GetViewModel();

	if ( pViewModel ~= NULL ) then

		--FIXME: add input library!!
		--if ( input.CAM_IsThirdPerson() ) then
		if ( true ) then
			data.m_hEntity = pViewModel;
		else
			data.m_hEntity = self;
		end
		DispatchEffect( "CrossbowLoad", data );
	end
end

	--Tony; switched this up, always attach it to the weapon, not the view model!!
if not _CLIENT then
	--FIXME: add CSprite object!!
	--[[
	local pBlast = _R.CSprite.SpriteCreate( CROSSBOW_GLOW_SPRITE2, self:GetAbsOrigin(), false );

	if ( pBlast ) then
		pBlast:SetAttachment( self, 1 );
		pBlast:SetTransparency( kRenderTransAdd, 255, 255, 255, 255, kRenderFxNone );
		pBlast:SetBrightness( 128 );
		pBlast:SetScale( 0.2 );
		pBlast:FadeOutFromSpawn();
	end
	]]
end
	
end

-------------------------------------------------------------------------------
-- Purpose: 
-- Input  : state - 
-------------------------------------------------------------------------------
function SWEP:SetChargerState( state )
	-- Make sure we're setup
	self:CreateChargerEffects();

	-- Don't do this twice
	if ( state == self.m_nChargeState ) then
		return;
	end

	self.m_nChargeState = state;

	if ( self.m_nChargeState == CHARGER_STATE_START_LOAD ) then
	
		self:WeaponSound( SPECIAL1 );
		
		-- Shoot some sparks and draw a beam between the two outer points
		self:DoLoadEffect();
		
	elseif ( self.m_nChargeState == CHARGER_STATE_OFF ) then
		self:SetSkin( BOLT_SKIN_NORMAL );

if not _CLIENT then
		if ( self.m_hChargerSprite == NULL ) then
			return;
		end
		
		self.m_hChargerSprite:SetBrightness( 0 );
		self.m_hChargerSprite:TurnOff();
end
	end
if not _CLIENT then
	if ( self.m_nChargeState == CHARGER_STATE_START_CHARGE ) then
		if ( m_hChargerSprite == NULL ) then
			return;
		end
		
		self.m_hChargerSprite:SetBrightness( 32, 0.5 );
		self.m_hChargerSprite:SetScale( 0.025, 0.5 );
		self.m_hChargerSprite:TurnOn();

	elseif ( self.m_nChargeState == CHARGER_STATE_READY ) then
		-- Get fully charged
		if ( self.m_hChargerSprite == NULL ) then
			return;
		end
		
		self.m_hChargerSprite:SetBrightness( 80, 1.0 );
		self.m_hChargerSprite:SetScale( 0.1, 0.5 );
		self.m_hChargerSprite:TurnOn();

	elseif ( self.m_nChargeState == CHARGER_STATE_DISCHARGE ) then
		self:SetSkin( BOLT_SKIN_NORMAL );
		
		if ( self.m_hChargerSprite == NULL ) then
			return;
		end
		
		self.m_hChargerSprite:SetBrightness( 0 );
		self.m_hChargerSprite:TurnOff();

	end
end
end

if not _CLIENT then
-------------------------------------------------------------------------------
-- Purpose: 
-- Input  : *pEvent - 
--			*pOperator - 
-------------------------------------------------------------------------------
function SWEP:Operator_HandleAnimEvent( pEvent, pOperator )
	if ( pEvent.event == EVENT_WEAPON_THROW ) then
		self:SetChargerState( CHARGER_STATE_START_LOAD );

	elseif ( pEvent.event == EVENT_WEAPON_THROW2 ) then
		self:SetChargerState( CHARGER_STATE_START_CHARGE );
	
	elseif ( pEvent.event == EVENT_WEAPON_THROW3 ) then
		self:SetChargerState( CHARGER_STATE_READY );

	else
		self.BaseClass:Operator_HandleAnimEvent( pEvent, pOperator );
	end
end

end

-------------------------------------------------------------------------------
-- Purpose: Set the desired activity for the weapon and its viewmodel counterpart
-- Input  : iActivity - activity to play
-------------------------------------------------------------------------------
function SWEP:SendWeaponAnim( iActivity )
	local newActivity = iActivity;

	-- The last shot needs a non-loaded activity
	if ( ( newActivity == 173 ) and ( self.m_iClip1 <= 0 ) ) then
		newActivity = 174;
	end

	--For now, just set the ideal activity and be done with it
	return _R.CBaseCombatWeapon.SendWeaponAnim( self, newActivity );
end
