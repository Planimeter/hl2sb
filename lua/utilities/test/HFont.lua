--========== Copyleft © 2012, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Tests the usage of HFont with surface library functions.
--
--===========================================================================--

if ( not bit ) then
  require( "bit" )
end
local bor = bit.bor
local vgui = require( "vgui" )
local Frame = vgui.Frame
local Panel = vgui.Panel

surface.AddCustomFontFile( "gamemodes\\sandbox\\content\\resource\\DINLi.ttf" )
local hTestFont = surface.CreateFont()
surface.SetFontGlyphSet( hTestFont,
                         "DIN-Light",
                         36,
                         0,
                         0,
                         0,
                         bit.bor( 0x010, 0x100, 0x400 )
                       )

g_hFontTestFrame = Frame()
g_hFontTestFrame:SetBounds( 0, 0, 408, 120 );
g_hFontTestFrame:SetSizeable( false )
g_hFontTestFrame:SetTitle( "Font Test", true )
g_hFontTestFrame:SetVisible( true )

g_hFontTestFrame.m_hFontSamples = Panel( g_hFontTestFrame, "FontSamples" )
g_hFontTestFrame.m_hFontSamples:SetSize( 408, 120 )

function g_hFontTestFrame.m_hFontSamples:Paint()
  surface.DrawSetTextFont( hTestFont )
  surface.DrawSetTextPos( 16, 60 + 8 - surface.GetFontTall( hTestFont ) / 2 )
  surface.DrawPrintText( "The five boxing wizards jump quickly." )
end

g_hFontTestFrame:DoModal()
