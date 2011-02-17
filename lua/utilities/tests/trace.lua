--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Tests the CGameTrace bindings.
--
--===========================================================================--

local pPlayer = UTIL_PlayerByIndex( 1 )

if ( pPlayer == NULL ) then
  return
end

local vForward = pPlayer:EyeVectors();

local vecEye = pPlayer:EyePosition();
local tr = UTIL_TraceLine( vecEye, vecEye + vForward * 65535, MASK_SHOT, pPlayer, COLLISION_GROUP_NONE );
print( tr )
local pEntity = tr.m_pEnt
print( pEntity )
if ( pEntity ~= NULL ) then
  pEntity:SetRenderColor( 255, 0, 0, 255 )
end
