--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Extends the table library.
--
--===========================================================================--

require( "table" )

local setmetatable = setmetatable
local getmetatable = getmetatable
local pairs = pairs

function table.copy( t, tRecursive )
  if ( t == nil ) then
    return nil
  end
  local __copy = {}
  setmetatable( __copy, getmetatable( t ) )
  for i, v in pairs( t ) do
    if ( type( v ) ~= "table" ) then
	  __copy[ i ] = v
	else
	  tRecursive = tRecursive or {}
	  tRecursive[ t ] = __copy
	  if ( tRecursive[ v ] ) then
	    __copy[ i ] = tRecursive[ v ]
	  else
	    __copy[ i ] = table.copy( v, tRecursive )
	  end
	end
  end
  return __copy
end

function table.inherit( t, BaseClass )
  for k, v in pairs( BaseClass ) do
    if ( t[ k ] == nil ) then
	  t[ k ] = v
	end
  end
  t.BaseClass = BaseClass
  return t
end
