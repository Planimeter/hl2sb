--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Shoot a fruit everyone loves.
--
--===========================================================================--

SWEP.__base					= "weapon_hl2mpbase_scriptedweapon"

SWEP.printname				= "MELON SHOOTER"
SWEP.viewmodel				= "models/weapons/v_357.mdl"
SWEP.playermodel			= "models/weapons/w_357.mdl"
SWEP.anim_prefix			= "python"
SWEP.bucket					= 1
SWEP.bucket_position		= 2

SWEP.clip_size				= 6
SWEP.clip2_size				= -1
SWEP.default_clip			= 6
SWEP.default_clip2			= -1
SWEP.primary_ammo			= "357"
SWEP.secondary_ammo			= "None"

SWEP.weight					= 7
SWEP.item_flags				= 0

SWEP.damage					= 75

SWEP.SoundData				=
{
	empty					= "Weapon_Pistol.Empty",
	single_shot				= "Weapon_357.Single"
}

SWEP.showusagehint			= 0
SWEP.autoswitchto			= 1
SWEP.autoswitchfrom			= 1
SWEP.BuiltRightHanded		= 1
SWEP.AllowFlipping			= 1
SWEP.MeleeWeapon			= 0

function SWEP:Initialize()
	self.m_bReloadsSingly	= false;
	self.m_bFiresUnderwater	= false;
end

function SWEP:Precache()
	_R.CBaseEntity.PrecacheModel( "models/props_junk/watermelon01.mdl" )
end

function SWEP:PrimaryAttack()
	-- Only the player fires this way so we can cast
	local pPlayer = self:GetOwner();

	if ( not pPlayer ) then
		return;
	end

	if ( self.m_iClip1 <= 0 ) then
		if ( not self.m_bFireOnEmpty ) then
			self:Reload();
		else
			self:WeaponSound( EMPTY );
			self.m_flNextPrimaryAttack = 0.15;
		end

		return;
	end

	self:WeaponSound( SINGLE );
	pPlayer:DoMuzzleFlash();

	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK or 180 );
	pPlayer:SetAnimation( PLAYER_ATTACK1 );
	-- pPlayer:DoAnimationEvent( PLAYERANIMEVENT_ATTACK_PRIMARY );

	self.m_flNextPrimaryAttack = gpGlobals.curtime() + 0.75;
	self.m_flNextSecondaryAttack = gpGlobals.curtime() + 0.75;

	self.m_iClip1 = self.m_iClip1 - 1;

	local vecSrc = pPlayer:Weapon_ShootPosition();
	local	vecThrow = pPlayer:GetAutoaimVector( AUTOAIM_5DEGREES );
	vecThrow = vecThrow * 5000.0;
	
if not CLIENT_LUA then
	--Create the melon
	local pMelon = CreateEntityByName( "prop_physics" );
	pMelon:SetModel( "models/props_junk/watermelon01.mdl" )
	pMelon:SetAbsOrigin( vecSrc );
	pMelon:SetAbsAngles( pPlayer:GetAbsAngles() );
	pMelon:Spawn();
	pMelon:SetOwnerEntity( pPlayer );
	pMelon:VPhysicsGetObject():SetVelocity( vecThrow );
end

	--Disorient the player
	local angles = pPlayer:GetLocalAngles();

	angles.x = angles.x + random.RandomInt( -1, 1 );
	angles.y = angles.y + random.RandomInt( -1, 1 );
	angles.z = 0;

if not CLIENT_LUA then
	-- pPlayer:SnapEyeAngles( angles );
end

	pPlayer:ViewPunch( QAngle( -8, random.RandomFloat( -2, 2 ), 0 ) );

	if ( not self.m_iClip1 and pPlayer:GetAmmoCount( self.m_iPrimaryAmmoType ) <= 0 ) then
		-- HEV suit - indicate out of ammo condition
		pPlayer:SetSuitUpdate( "!HEV_AMO0", 0, 0 );
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	local fRet = self:DefaultReload( self:GetMaxClip1(), self:GetMaxClip2(), ACT_VM_RELOAD );
	if ( fRet ) then
		self:WeaponSound( RELOAD );
		self:GetOwner():DoAnimationEvent( PLAYERANIMEVENT_RELOAD );
	end
	return fRet;
end

function SWEP:Think()
end

function SWEP:CanHolster()
end

function SWEP:Holster()
end

function SWEP:Deploy()
end

function SWEP:ItemPostFrame()
end

function SWEP:DoImpactEffect()
end
