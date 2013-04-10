--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Tests the KeyValues implementation.
--
--===========================================================================--

local gamePath
if _CLIENT then
	gamePath = engine.GetGameDirectory();
else
	gamePath = engine.GetGameDir();
end

local pMainFile = KeyValues( "gamecontent.txt" );
if ( pMainFile:LoadFromFile( gamePath .. "/GameContent.txt", "MOD" ) ) then
	local pFileSystemInfo = pMainFile:FindKey( "FileSystem" );
	local pKey = pFileSystemInfo:GetFirstSubKey();
	while pKey ~= NULL_KEYVALUES do
		if ( pKey:GetName() == "AppId" ) then
			local nExtraContentId = pKey:GetInt();
			if (nExtraContentId) then
				print( nExtraContentId );
			end
		end
		pKey = pKey:GetNextKey();
	end
end
pMainFile:deleteThis();
