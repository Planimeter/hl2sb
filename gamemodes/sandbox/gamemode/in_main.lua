--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: builds an intended command to send to the server
--
--===========================================================================--

require( "concommand" )

local function IN_BuildDown( pPlayer, pCmd, args )
	print( "IN_BuildDown:" )
	print( "\t" .. tostring( pPlayer ) )
	print( "\t" .. pCmd )
	print( "\t" .. args )
end

concommand.Create( "+buildmenu", IN_BuildDown, nil, 2^3 )

local function IN_BuildUp( pPlayer, pCmd, args )
	print( "IN_BuildUp:" )
	print( "\t" .. tostring( pPlayer ) )
	print( "\t" .. pCmd )
	print( "\t" .. args )
end

concommand.Create( "-buildmenu", IN_BuildUp, nil, 2^3 )
