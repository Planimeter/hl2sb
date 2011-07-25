--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Shoot a fruit everyone loves.
--
--===========================================================================--

SWEP.__base					= "weapon_hl2mpbase_scriptedweapon"

SWEP.printname				= "MELON SHOOTER"

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
	pMelon:VPhysicsGetObject():SetVelocity( vecThrow, vec3_origin );
end

	--Disorient the player
	local angles = pPlayer:GetLocalAngles();

	angles.x = angles.x + random.RandomInt( -1, 1 );
	angles.y = angles.y + random.RandomInt( -1, 1 );
	angles.z = 0;

if not CLIENT_LUA then
	pPlayer:SnapEyeAngles( angles );
end

	pPlayer:ViewPunch( QAngle( -8, random.RandomFloat( -2, 2 ), 0 ) );

	if ( not self.m_iClip1 and pPlayer:GetAmmoCount( self.m_iPrimaryAmmoType ) <= 0 ) then
		-- HEV suit - indicate out of ammo condition
		pPlayer:SetSuitUpdate( "!HEV_AMO0", 0, 0 );
	end
end
