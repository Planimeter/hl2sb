--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Tests the CGameTrace bindings.
--
--===========================================================================--

local MASK_SHOT = 1174421507
local COLLISION_GROUP_NONE = 0

local pPlayer = UTIL.PlayerByIndex( 1 )

if ( pPlayer == NULL ) then
  return
end

local vForward = pPlayer:EyeVectors();

local vecEye = pPlayer:EyePosition();
local tr = UTIL.TraceLine( vecEye, vecEye + vForward * 65535, MASK_SHOT, pPlayer, COLLISION_GROUP_NONE );
print( tr )
local pEntity = tr.m_pEnt
print( pEntity )
if ( pEntity ~= NULL ) then
  print( pEntity:GetModelName() )
  pEntity:SetRenderColor( 255, 0, 0, 255 )
end
