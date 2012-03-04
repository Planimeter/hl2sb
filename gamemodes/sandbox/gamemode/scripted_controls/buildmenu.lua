--========= Copyleft © 2010, Team Sandbox, Some rights reserved. ============--
--
-- Purpose:
--
-- $NoKeywords: $
--===========================================================================--

local vgui = vgui;
local CBuildSubMenu = vgui.CBuildSubMenu
local ScreenWidth = UTIL.ScreenWidth
local ScreenHeight = UTIL.ScreenHeight

local CBuildMenu = {}

-------------------------------------------------------------------------------
-- Purpose: Constructor
-------------------------------------------------------------------------------
function CBuildMenu:Init(pViewPort)
	self:SetScheme("ClientScheme");

	self:SetProportional(true);
	-- Make it screen sized
	self:SetBounds( 0, 0, ScreenWidth(), ScreenHeight() );


	self:SetAutoDelete( false ); -- we reuse this panel, don't let WizardPanel delete us
	
	self.m_pViewPort = pViewPort;

if false then
	self.m_pMainMenu = CBuildSubMenu( self, "mainmenu" );
	self.m_pMainMenu:LoadControlSettings( "Resource/UI/MainBuyMenu.res" );
	self.m_pMainMenu:SetVisible( false );
end
	self:SetVisible( false )
end

-------------------------------------------------------------------------------
-- Purpose: shows/hides the buy menu
-------------------------------------------------------------------------------
function CBuildMenu:ShowPanel(bShow)
	if ( self:IsVisible() == bShow ) then
		return;
	end

	if ( bShow ) then
		self:Update();

if false then
		self:Run( self.m_pMainMenu );
end

		self:SetMouseInputEnabled( true );
		self:SetVisible( true )
		self:MakePopup();
	else
		self:SetVisible( false );
		self:SetMouseInputEnabled( false );
	end

if false then
	self.m_pViewPort:ShowBackGround( bShow );
end
end


function CBuildMenu:Update()
	--Don't need to do anything, but do need to implement this function as base is pure virtual
end
function CBuildMenu:OnClose()
	self.BaseClass:OnClose();
	self:ResetHistory();
end

vgui.register( CBuildMenu, "CBuildMenu", "Panel" )
