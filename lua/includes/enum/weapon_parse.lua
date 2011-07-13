--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Weapon data file parsing, shared by game & client dlls.
--
--===========================================================================--

-- -----------------------------------------------------------
-- Weapon sound types
-- Used to play sounds defined in the weapon's classname.txt file
-- This needs to match pWeaponSoundCategories in weapon_parse.cpp
-- ------------------------------------------------------------
EMPTY = 0
SINGLE = 1
SINGLE_NPC = 2
WPN_DOUBLE = 3 -- Can't be "DOUBLE" because windows.h uses it.
DOUBLE_NPC = 4
BURST = 5
RELOAD = 6
RELOAD_NPC = 7
MELEE_MISS = 8
MELEE_HIT = 9
MELEE_HIT_WORLD = 10
SPECIAL1 = 11
SPECIAL2 = 12
SPECIAL3 = 13
TAUNT = 14

-- Add new shoot sound types here

NUM_SHOOT_SOUND_TYPES = 15

MAX_SHOOT_SOUNDS	= 16		-- Maximum number of shoot sounds per shoot type

MAX_WEAPON_STRING	= 80
MAX_WEAPON_PREFIX	= 16
MAX_WEAPON_AMMO_NAME		= 32

WEAPON_PRINTNAME_MISSING = "!!! Missing printname on weapon"
