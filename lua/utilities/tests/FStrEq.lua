--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Tests the speed of FStrEq vs "".__eq.
--
--===========================================================================--

local Time = engine.Time
local flTimeExecution
local print = print
local FStrEq = FStrEq
local flTimeFStrEq
local flTime__eq
local Warning = dbg.Warning

local strChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.~"
local srahCtrs = "~._-9876543210ZYXWVUTSRQPONMLKJIHGFEDCBAzyxwvutsrqponmlkjihgfedcba"

flTimeExecution = Time()
print( FStrEq( strChars, srahCtrs ) )
flTimeExecution = Time() - flTimeExecution

flTimeFStrEq = flTimeExecution

flTimeExecution = Time()
print( strChars == srahCtrs )
flTimeExecution = Time() - flTimeExecution

flTime__eq = flTimeExecution

if ( flTimeFStrEq < flTime__eq ) then
  Warning( "FStrEq beat \"\".__eq by " .. flTime__eq - flTimeFStrEq .. " seconds!\n" )
elseif ( flTime__eq < flTimeFStrEq ) then
  Warning( "\"\".__eq beat FStrEq by " .. flTimeFStrEq - flTime__eq .. " seconds!\n" )
end
