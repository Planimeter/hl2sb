--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: builds an intended command to send to the server
--
--===========================================================================--

local FCVAR_GAMEDLL = _E.FVAR.GAMEDLL

require( "concommand" )

local function IN_BuildDown( pPlayer, pCmd, args )
	print( "IN_BuildDown:" )
	print( "\t" .. tostring( pPlayer ) )
	print( "\t" .. pCmd )
	print( "\t" .. args )
end

concommand.Create( "+buildmenu", IN_BuildDown, nil, FCVAR_GAMEDLL )

local function IN_BuildUp( pPlayer, pCmd, args )
	print( "IN_BuildUp:" )
	print( "\t" .. tostring( pPlayer ) )
	print( "\t" .. pCmd )
	print( "\t" .. args )
end

concommand.Create( "-buildmenu", IN_BuildUp, nil, FCVAR_GAMEDLL )
