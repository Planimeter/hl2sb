--======== Copyleft © 2010-2013, Team Sandbox, Some rights reserved. ========--
--
-- Purpose:
--
--===========================================================================--

ENT.__base = "trigger_scripted"
ENT.__factory = "CBaseAnimating"

function ENT:Initialize()
	local w = self.m_vecMaxs.x - self.m_vecMins.x
	local l = self.m_vecMaxs.y - self.m_vecMins.y
	local h = self.m_vecMaxs.z - self.m_vecMins.z
	
	local mins = Vector( 0 - ( w / 2 ), 0 - ( l / 2 ), 0 - ( h / 2 ) )
	local maxs = Vector( w / 2, l / 2, h / 2 )
	
	self:DrawShadow( false )
	self:SetCollisionBounds( mins, maxs )
	self:SetSolid( 2 )
	self:SetCollisionGroup( 1 )
	self:SetMoveType( 0 )
end

function ENT:PassesTriggerFilters( pOther )
end

function ENT:Think( pOther )
end

function ENT:StartTouch( pOther )
end

function ENT:Touch( pOther )
end

function ENT:EndTouch( pOther )
end
