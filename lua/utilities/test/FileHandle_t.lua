--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Tests the FileHandle_t implementation.
--
--===========================================================================--

require( "filesystem" )

local hFile = filesystem.Open( "gamecontent.txt", "r" )
print( hFile )
local size, pOutput = filesystem.Read( hFile )
print( "size: " .. size )
print( "output:\n" .. pOutput )
filesystem.Close( hFile )
