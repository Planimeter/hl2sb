--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

local Msg = dbg.Msg

include( "shared.lua" )

function ENT:Think()
	Msg( "Hello, game!\n" )
	-- Andrew; think every 5 seconds.
	self:SetNextThink( gpGlobals.curtime() + 5.0 )
end
