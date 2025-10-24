core.after(0, function()

local liquid_swords = {} -- Table for storing runtime mod data
liquid_swords.liquid_nodes = {} -- Table for storing liquid nodes
for itemname, _ in pairs(core.registered_nodes) do
    local is_liquid = core.get_node_group(itemname, "liquid")
    local is_not_flowing = core.get_node_group(itemname, "flowing") == 0
    local is_source_name = itemname:find("_source$")
    if is_liquid and is_not_flowing and is_source_name then
        table.insert(liquid_swords.liquid_nodes, itemname)
    end
end

for _, itemname in pairs(liquid_swords.liquid_nodes) do -- For each liquid node
    local def = core.registered_nodes[itemname] -- Get the node definition
	local shortname = itemname:match("([^:]+)$") -- Get the itemname without the modname
	local name_from_source = nil -- Actual itemname being used for the sword
	if shortname:find("_source") then -- If "_source" is found in the itemname
		name_from_source = shortname:gsub("_source", "") -- Remove "_source"
  	else
    	name_from_source = shortname -- Otherwise keep the itemname
	end
	local description_from_source = core.registered_nodes[itemname].description -- Get the node description
	local description = nil -- Actual description for the sword
	if description_from_source:find(" Source") then -- If "Source" is found in the itemname
    	description = description_from_source:gsub(" Source", "") .. " Sword" -- Remove "Source"
  	else
    	description = description_from_source .. " Sword" -- Otherwise keep the description
	end
	local source_texture = nil
    local texture_data = def.tiles
    if type(texture_data) == "string" then
        source_texture = texture_data
    elseif type(texture_data) == "table" and texture_data[1] then
        local first_tile = texture_data[1]
    if type(first_tile) == "string" then
        source_texture = first_tile
    elseif type(first_tile) == "table" and first_tile.name then
        source_texture = first_tile.name
    end
end
    if not source_texture then
        core.log("warning", "[liquid_swords] Skipping "..itemname)
        goto continue
    end
	local sword_image = "liquid_swords_base.png^(liquid_swords_blade.png^("..source_texture.."))"
    local final_sword_name = "ls:" .. "sword_" .. name_from_source
	core.register_tool(final_sword_name, {
		description = description,
		inventory_image = sword_image,
		wield_image = sword_image,
		groups = {sword = 1, liquid_sword = 1},
		max_uses = 120,
		sound = "default_tool_hit",
		tool_capabilities = {
			full_punch_interval = 0.5,
			groupcaps = {
				fleshy = {
					damage = 4,
					uses = 1,
				}
			}
		}
	})
    ::continue::
end

end)
