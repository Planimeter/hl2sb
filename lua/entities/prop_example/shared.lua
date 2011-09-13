--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

local Warning = dbg.Warning

function ENT:Initialize()
	local allowPrecache = self.IsPrecacheAllowed();
	self.SetAllowPrecache( true );
	self.PrecacheModel( "models/props_junk/wood_crate001a.mdl" );
	self:SetModel( "models/props_junk/wood_crate001a.mdl" )
	self.SetAllowPrecache( allowPrecache );
	local pPhysicsObject = self:VPhysicsInitNormal( 6, 0, false );

	if ( not pPhysicsObject ) then
		self:SetSolid( 0 );
		self:SetMoveType( 0 );
		Warning("ERROR!: Can't create physics object for " .. self:GetModelName() .. "\n" );
	end
end

local velocity, angularVelocity;

function ENT:VPhysicsUpdate( pPhysics )
	if ( pPhysics:IsGravityEnabled() ) then
		pPhysics:EnableGravity( false )
	end
	velocity, angularVelocity = pPhysics:GetVelocity()
	pPhysics:SetVelocity( velocity - ( velocity / 10 ), angularVelocity - ( angularVelocity / 10 ) )
end
