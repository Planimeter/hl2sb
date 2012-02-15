--======== Copyleft © 2010-2011, Team Sandbox, Some rights reserved. ========--
--
-- Purpose: Tests the speed of FStrEq vs "".__eq.
--
--===========================================================================--

local Count = 10000
local Time = engine.Time
local flTimeExecution
local print = print
local FStrEq = FStrEq
local flTimeFStrEq
local flTime__eq
local Warning = dbg.Warning

local strChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.~"
local srahCtrs = "~._-9876543210ZYXWVUTSRQPONMLKJIHGFEDCBAzyxwvutsrqponmlkjihgfedcba"

local FStrEq_ret = 0
flTimeExecution = Time()
for i = 1, Count do
    FStrEq_ret = FStrEq_ret+( FStrEq( strChars, srahCtrs ) and 1 or 0 )
end
flTimeExecution = Time() - flTimeExecution

flTimeFStrEq = flTimeExecution

local __eq_ret = 0
flTimeExecution = Time()
for i = 1, Count do
    __eq_ret = __eq_ret + ( strChars == srahCtrs and 1 or 0 )
end
flTimeExecution = Time() - flTimeExecution

flTime__eq = flTimeExecution

if ( flTimeFStrEq < flTime__eq ) then
  Warning( "FStrEq beat \"\".__eq by " .. flTime__eq - flTimeFStrEq .. " seconds!\n", FStrEq_ret, __eq_ret )
elseif ( flTime__eq < flTimeFStrEq ) then
  Warning( "\"\".__eq beat FStrEq by " .. flTimeFStrEq - flTime__eq .. " seconds!\n", __eq_ret, FStrEq_ret )
end
