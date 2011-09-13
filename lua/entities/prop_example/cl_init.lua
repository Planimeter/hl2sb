--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

local Msg = dbg.Msg

include( "shared.lua" )

function ENT:ClientThink()
	Msg( "Hello, client!\n" )
	-- Andrew; think every 5 seconds.
	self:SetNextClientThink( gpGlobals.curtime() + 5.0 )
end
