local liquid_swords = {} -- Table for storing runtime mod data
liquid_swords.liquid_nodes = {} -- Table for storing liquid nodes
for itemname, _ in pairs(core.registered_nodes) do -- For every registered node,
	if core.get_node_group(itemname, "liquid") and luanti.get_node_group(name, "flowing") == 0 then -- If the node is a liquid source
	table.insert(liquid_swords.liquid_nodes, itemname) -- Add it to the table of liquid nodes
	end
end

for itemname in liquid_swords.liquid_nodes do -- For each liquid node
	local shortname = itemname:match("([^:]+)$") -- Get the itemname without the modname
	local name_from_source = nil -- Actual itemname being used for the sword
	if shortname:find("_source") then -- If "_source" is found in the itemname
		name_from_source = name:gsub("_source", "") -- Remove "_source"
  	else
    	name_from_source = name -- Otherwise keep the itemname
	end
	local description_from_source = core.registered_nodes[itemname].description -- Get the node description
	local description = nil -- Actual description for the sword
	if description_from_source:find(" Source") then -- If "Source" is found in the itemname
    	description = description_from_source:gsub(" Source", "") .. " Sword" -- Remove "Source"
  	else 
    	description = description_from_source .. " Sword" -- Otherwise keep the description
	end
	local source_texture = nil
	if type(def.tiles) == "table" and def.tiles[1] then
            source_texture = def.tiles[1]
    elseif type(def.tiles) == "string" then
        source_texture = def.tiles
    end
	local sword_image = "liquid_swords_base.png^(liquid_swords_blade.png^(source_texture))"
	core.register_tool("liquid_swords:sword_"..name_from_source, {
		description = description,
		inventory_image = sword_image,
		wield_image = sword_image,
		groups = {sword = 1, liquid_sword = 1},
		max_uses = 120
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
end
