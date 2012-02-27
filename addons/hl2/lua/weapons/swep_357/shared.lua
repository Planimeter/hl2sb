
--========= Copyright © 1996-2005, Valve Corporation, All rights reserved. ============--
--
-- Purpose: 
--
--=============================================================================--

-- 357

-- Weapon data is loaded by both the Game and Client DLLs.
SWEP.printname			= "#HL2_357Handgun"
SWEP.viewmodel			= "models/weapons/v_357.mdl"
SWEP.playermodel		= "models/weapons/w_357.mdl"
SWEP.anim_prefix		= "python"
SWEP.bucket			= 1
SWEP.bucket_position	= 1

SWEP.clip_size			= 6
SWEP.default_clip		= 6
SWEP.primary_ammo		= "357"
SWEP.secondary_ammo	= "None"

SWEP.weight		= 7
SWEP.item_flags		= 0

SWEP.damage		= 75

-- Sounds for the weapon. There is a max of 16 sounds per category (i.e. max 16 "single_shot" sounds)
SWEP.SoundData =
{
	empty		= "Weapon_Pistol.Empty",
	single_shot	= "Weapon_357.Single"
}

-------------------------------------------------------------------------------
-- SWeapon357
-------------------------------------------------------------------------------

SWEP.m_acttable	= 
{
	{ 1048, 977, false },
	{ 1049, 979, false },

	{ 1058, 978, false },
	{ 1061, 980, false },

	{ 1073, 981, false },
	{ 1077, 981, false },

	{ 1090, 982, false },
	{ 1093, 982, false },

	{ 1064, 983, false },
};

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function SWEP:Initialize()
	self.m_bReloadsSingly	= false;
	self.m_bFiresUnderwater	= false;
end

-------------------------------------------------------------------------------
-- Purpose:
-------------------------------------------------------------------------------
function SWEP:PrimaryAttack()
	-- Only the player fires this way so we can cast
	local pPlayer = self:GetOwner();

	if ( pPlayer == NULL ) then
		return;
	end

	if ( self.m_iClip1 <= 0 ) then
		if ( not self.m_bFireOnEmpty ) then
			self:Reload();
		else
			self:WeaponSound( 0 );
			self.m_flNextPrimaryAttack = 0.15;
		end

		return;
	end

	--self:WeaponSound( 1 );
	if ( gpGlobals.maxClients() > 1 ) then
		self:WeaponSound( 1 );
	else
		local shootsound = self:GetShootSound( 1 );
		pPlayer:EmitSound( shootsound ); 
	end
	pPlayer:DoMuzzleFlash();

	self:SendWeaponAnim( 180 );
	pPlayer:SetAnimation( 5 );
	ToHL2MPPlayer(pPlayer):DoAnimationEvent( 0 );

	self.m_flNextPrimaryAttack = gpGlobals.curtime() + 0.75;
	self.m_flNextSecondaryAttack = gpGlobals.curtime() + 0.75;

	self.m_iClip1 = self.m_iClip1 - 1;

	local vecSrc		= pPlayer:Weapon_ShootPosition();
	local vecAiming		= pPlayer:GetAutoaimVector( 0.08715574274766 );

	local info = { m_iShots = 1, m_vecSrc = vecSrc, m_vecDirShooting = vecAiming, m_vecSpread = vec3_origin, m_flDistance = MAX_TRACE_LENGTH, m_iAmmoType = self.m_iPrimaryAmmoType };
	info.m_pAttacker = pPlayer;

	-- Fire the bullets, and force the first shot to be perfectly accuracy
	pPlayer:FireBullets( info );

	--Disorient the player
	local angles = pPlayer:GetLocalAngles();

	angles.x = angles.x + random.RandomInt( -1, 1 );
	angles.y = angles.y + random.RandomInt( -1, 1 );
	angles.z = 0;

if not _CLIENT then
	pPlayer:SnapEyeAngles( angles );
end

	pPlayer:ViewPunch( QAngle( -8, random.RandomFloat( -2, 2 ), 0 ) );

	if ( self.m_iClip1 == 0 and pPlayer:GetAmmoCount( self.m_iPrimaryAmmoType ) <= 0 ) then
		-- HEV suit - indicate out of ammo condition
		pPlayer:SetSuitUpdate( "!HEV_AMO0", 0, 0 );
	end
end
