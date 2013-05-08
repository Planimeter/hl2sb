--========= Copyleft © 1996-2005, Team Sandbox, Some rights reserved. ============--
--
-- Purpose: 
--
-- $NoKeywords: $
--
--=============================================================================--
include( "../includes/extensions/table.lua" );
include( "../includes/extensions/vgui.lua" );

local vgui = vgui;

local CContentSubGames = {
	m_pHalfLife2CheckBox = INVALID_PANEL,
	m_pCounterStrikeCheckBox = INVALID_PANEL,
	m_pHalfLifeCheckBox = INVALID_PANEL,
	m_pDayOfDefeatCheckBox = INVALID_PANEL,
	m_pLostCoastCheckBox = INVALID_PANEL,
	m_pHalfLifeDeathmatchCheckBox = INVALID_PANEL,
	m_pEpisodicCheckBox = INVALID_PANEL,
	m_pPortalCheckBox = INVALID_PANEL,
	m_pEpisodeTwoCheckBox = INVALID_PANEL,
	m_pTeamFortressCheckBox = INVALID_PANEL
}

function CContentSubGames:Init(parent)
	self.m_pHalfLife2CheckBox = vgui.CheckButton( 
		self, 
		"HalfLife2", 
		"Half-Life 2" );
	
	self.m_pCounterStrikeCheckBox = vgui.CheckButton( 
		self, 
		"CounterStrike", 
		"Counter-Strike: Source" );

	self.m_pHalfLifeCheckBox = vgui.CheckButton( 
		self, 
		"HalfLife", 
		"Half-Life: Source" );

	self.m_pDayOfDefeatCheckBox = vgui.CheckButton( 
		self, 
		"DayOfDefeat", 
		"Day of Defeat: Source" );

	self.m_pLostCoastCheckBox = vgui.CheckButton( 
		self, 
		"LostCoast", 
		"Half-Life 2: Lost Coast" );

	self.m_pHalfLifeDeathmatchCheckBox = vgui.CheckButton( 
		self, 
		"HalfLifeDeathmatch", 
		"Half-Life Deathmatch: Source" );

	self.m_pEpisodicCheckBox = vgui.CheckButton( 
		self, 
		"Episodic", 
		"Half-Life 2: Episode One" );

	self.m_pPortalCheckBox = vgui.CheckButton( 
		self, 
		"Portal", 
		"Portal" );

	self.m_pEpisodeTwoCheckBox = vgui.CheckButton( 
		self, 
		"EpisodeTwo", 
		"Half-Life 2: Episode Two" );

	self.m_pTeamFortressCheckBox = vgui.CheckButton( 
		self, 
		"TeamFortress", 
		"Team Fortress 2" );

	self:LoadControlSettings("Resource\\ContentSubGames.res");
end

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function CContentSubGames:OnResetData()
end

-------------------------------------------------------------------------------
-- Purpose: 
-------------------------------------------------------------------------------
function CContentSubGames:OnApplyChanges()
end

vgui.register( CContentSubGames, "CContentSubGames", "PropertyPage" )
