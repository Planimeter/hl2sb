--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Scripted entity implementation.
--
--===========================================================================--

-- Andrew; We'll have multiple internal base classes, but all of those internal
-- classes inherit from CBaseAnimating, so this is our default.
_BASE_ENTITY_CLASS = "CBaseAnimating"

local table = table
local Warning = dbg.Warning

module( "entity" )

local tEntities = {}

-- These are our internal base classes we can inherit from. In the event our
-- entity's __base metafield is equal to one of these, it inherits directly
-- from an internal class, and not another scripted entity.
-- TODO: add more entity types, such as point and brush!!
local tEntityBaseClasses = {
	"CBaseAnimating"
}

-------------------------------------------------------------------------------
-- Purpose: Returns an entity table
-- Input  : strName - Name of the entity
-- Output : table
-------------------------------------------------------------------------------
function Get( strClassname )
  local tEntity = tEntities[ strClassname ]
  if ( not tEntity ) then
    return nil
  end
  tEntity = table.copy( tEntity )
  if ( not table.hasvalue( tEntityBaseClasses, tEntity.__base ) ) then
    local tBaseEntity = Get( tEntity.__base )
    if ( not tBaseEntity ) then
	  Warning( "WARNING: Attempted to initialize entity \"" .. strClassname .. "\" with non-existing base class!\n" )
	else
	  return table.inherit( tEntity, tBaseEntity )
	end
  end
  return tEntity
end

-------------------------------------------------------------------------------
-- Purpose: Returns all registered entities
-- Input  :
-- Output : table
-------------------------------------------------------------------------------
function GetEntities()
  return tEntities
end

-------------------------------------------------------------------------------
-- Purpose: Registers an entity
-- Input  : tEntity - Entity table
--			strClassname - Name of the entity
--			bReload - Whether or not we're reloading this entity data
-- Output :
-------------------------------------------------------------------------------
function Register( tEntity, strClassname, bReload )
  if ( Get( strClassname ) ~= nil and bReload ~= true ) then
    return
  end
  tEntities[ strClassname ] = tEntity
end
