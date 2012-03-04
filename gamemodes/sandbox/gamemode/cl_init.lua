--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose:
--
--===========================================================================--

include( "shared.lua" )
include( "in_main.lua" )
include( "scripted_controls/buildmenu.lua" )

function GM:CreateDefaultPanels()
  gBuildMenuInterface = vgui.CBuildMenu( VGui_GetClientLuaRootPanel(), "build" )

  surface.AddCustomFontFile( "gamemodes/sandbox/content/resource/DINLi.ttf" )
  gBuildMenuInterface.m_hFonts[ 1 ] = surface.CreateFont()
  surface.SetFontGlyphSet(
  	gBuildMenuInterface.m_hFonts[ 1 ],
  	"DIN-Light",
  	64,
  	0,
  	5,
  	2,
  	0x010 + 0x100 + 0x400
  )
end
