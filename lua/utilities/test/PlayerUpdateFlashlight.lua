--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Tests the implementation of the PlayerUpdateFlashlight hook.
--
--===========================================================================--

hook.add( "PlayerUpdateFlashlight", "PlayerUpdateWeaponFlashlight", function( pHL2MPPlayer, position, vecForward, vecRight, vecUp, nDistance )
	--if ( not input.CAM_IsThirdPerson() ) then
		print( pHL2MPPlayer )
		local iAttachment = pHL2MPPlayer:LookupAttachment( "anim_attachment_RH" );

		if ( iAttachment >= 0 ) then
			local vecOrigin = Vector();
			--Tony; EyeAngles will return proper whether it's local player or not.
			local eyeAngles = pHL2MPPlayer:EyeAngles();

			pHL2MPPlayer:GetAttachment( iAttachment, vecOrigin, eyeAngles );

			local vForward = Vector();
			AngleVectors( eyeAngles, vecForward, vecRight, vecUp );
			position = vecOrigin;
		else
			pHL2MPPlayer:EyeVectors( vecForward, vecRight, vecUp );
		end
		return position, vecForward, vecRight, vecUp, nDistance
	--end
end )
