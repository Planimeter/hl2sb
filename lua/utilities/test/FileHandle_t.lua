--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Tests the FileHandle_t implementation.
--
--===========================================================================--

require( "filesystem" )

local hFile = filesystem.Open( "gamecontent.txt", "r" )
local size = filesystem.Size( hFile )
print( "hFile = " .. tostring( hFile ) )
local bytesRead, pOutput = filesystem.Read( size, hFile )
print( "bytes: " .. bytesRead )
print( "output:\n" .. pOutput )
print( "Closing hFile, handle should become invalid!" )
filesystem.Close( hFile )
print( "hFile = " .. tostring( hFile ) )

-- Andrew; this will error intentionally as a part of the test to ensure
-- luaL_checkfilehandle() works internally.
print( "Testing error handling..." )
-- While this may seem confusing at first, filesystem.IsOk() doesn't seem to
-- allow FILESYSTEM_INVALID_HANDLE, despite it's name indicating checking
-- validity of any kind. It will error at the engine level and print a warning,
-- but not crash the game. As a result, it's valid for testing error handling
-- here to reflect actual Source SDK usage, even though we sort of baby
-- developers here at our auxiliary library level.
print( "filesystem.IsOk( hFile ) = " .. tostring( filesystem.IsOk( hFile ) ) )

print( "Testing error handling with non-filehandle userdatum...")
-- Internally, this function doesn't use luaL_checkfilehandle(), but rather
-- lua_tofilehandle(). Here we test converting non-userdata to plain userdatum
-- to FileHandle_t internally. Crashing at this level will indicate us using an
-- invalid reference.
print( "filesystem.IsOk( hFile ) = " .. tostring( filesystem.IsOk( "ABC" ) ) )
