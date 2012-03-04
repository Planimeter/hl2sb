--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

include( "shared.lua" )
include( "in_main.lua" )
include( "scripted_controls/buildmenu.lua" )

function GM:CreateDefaultPanels()
  self.gBuildMenuInterface = vgui.CBuildMenu( VGui_GetClientLuaRootPanel(), "build" )
end
