--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: builds an intended command to send to the server
--
--===========================================================================--

local FCVAR_CLIENTDLL = _E.FCVAR.CLIENTDLL

require( "concommand" )

local function IN_BuildDown( pPlayer, pCmd, args )
if not _CLIENT then
	if ( pPlayer == NULL ) then
		local pWeapon = pPlayer:GetActiveWeapon()
		if ( pWeapon ~= NULL ) then
			pWeapon:Lower()
		end
	end
end
end

concommand.Create( "+buildmenu", IN_BuildDown, nil, FCVAR_CLIENTDLL )

local function IN_BuildUp( pPlayer, pCmd, args )
if not _CLIENT then
	if ( pPlayer == NULL ) then
		local pWeapon = pPlayer:GetActiveWeapon()
		if ( pWeapon ~= NULL ) then
			pWeapon:Raise()
		end
	end
end
end

concommand.Create( "-buildmenu", IN_BuildUp, nil, FCVAR_CLIENTDLL )
