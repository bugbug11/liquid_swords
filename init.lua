liquid_swords = {}
liquid_swords.MODNAME = core.get_current_modname()
liquid_swords.MODPATH = core.get_modpath(liquid_swords.MODNAME)
local MODPATH = liquid_swords.MODPATH

-- Get all liquids
dofile(MODPATH.."/liquids.lua")

-- Get all liquid properties
dofile(MODPATH.."/liquid_properties.lua")

-- Register all swords
dofile(MODPATH.."/register_swords.lua")
