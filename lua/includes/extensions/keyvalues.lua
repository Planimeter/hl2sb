--========== Copyleft © 2013, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Extends the keyvalues type.
--
--===========================================================================--

local print = print

function _R.KeyValues.Print( self, i )
  i = i or 0
  local indent = ""
  for j = 1, i do
    indent = indent .. "\t"
  end
  local kv = self:GetFirstSubKey()
  while kv ~= NULL_KEYVALUES do
    local k, v = kv:GetName(), kv:GetString()
    print( indent .. k, v )
    kv:Print( i + 1 )
    kv = kv:GetNextKey()
  end
end

function _R.KeyValues.ToTable( self )
  local t = {}
  local pair = self:GetFirstSubKey()
  while pair ~= NULL_KEYVALUES do
    local k, v = pair:GetName(), pair:GetString()
    t[ k ] = v
    if ( t[ k ] == "" and self:GetDataType( pair:GetName() ) == 0 ) then
      t[ k ]  = pair:ToTable()
      local isEmpty = true
      for l, w in pairs( t[ k ] ) do
        if ( w ) then
          isEmpty = false
          break
        end
      end
      if ( isEmpty ) then
        t[ k ] = ""
      end
    end
    pair = pair:GetNextKey()
  end
  return t
end
