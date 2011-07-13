--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--
-- worldsize.h  -- extent of world and resolution/size of coordinate messages used in engine


-- These definitions must match the coordinate message sizes in coordsize.h

-- Following values should be +16384, -16384, +15/16, -15/16
-- NOTE THAT IF THIS GOES ANY BIGGER THEN DISK NODES/LEAVES CANNOT USE SHORTS TO STORE THE BOUNDS
MAX_COORD_INTEGER			= (16384)
MIN_COORD_INTEGER			= (-MAX_COORD_INTEGER)
MAX_COORD_FRACTION			= (1.0-(1.0/16.0))
MIN_COORD_FRACTION			= (-1.0+(1.0/16.0))

MAX_COORD_FLOAT				= (16384.0)
MIN_COORD_FLOAT				= (-MAX_COORD_FLOAT)

-- Width of the coord system, which is TOO BIG to send as a client/server coordinate value
COORD_EXTENT				= (2*MAX_COORD_INTEGER)

-- Maximum traceable distance ( assumes cubic world and trace from one corner to opposite )
-- COORD_EXTENT * sqrt(3)
MAX_TRACE_LENGTH			= ( 1.732050807569 * COORD_EXTENT )

-- This value is the LONGEST possible range (limited by max valid coordinate number, not 2x)
MAX_COORD_RANGE				= (MAX_COORD_INTEGER)

function ASSERT_COORD( v ) assert( (v.x>=MIN_COORD_INTEGER*2) and (v.x<=MAX_COORD_INTEGER*2) and
								  (v.y>=MIN_COORD_INTEGER*2) and (v.y<=MAX_COORD_INTEGER*2) and
								  (v.z>=MIN_COORD_INTEGER*2) and (v.z<=MAX_COORD_INTEGER*2) );
end
