--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

local velocity, angularVelocity;

function ENT:VPhysicsUpdate( pPhysics )
	if ( pPhysics:IsGravityEnabled() ) then
		pPhysics:EnableGravity( false )
	end
	velocity, angularVelocity = pPhysics:GetVelocity()
	pPhysics:SetVelocity( velocity - ( velocity / 10 ), angularVelocity - ( angularVelocity / 10 ) )
end
