local liquid_swords = {} -- Table for storing runtime mod data
liquid_swords.liquid_nodes = {} -- Table for storing liquid nodes
for name, _ in pairs(core.registered_nodes) do -- For every registered node,
  if core.get_node_group(name, "liquid") then -- If the node is in the liquid group,
	  table.insert(liquid_swords.liquid_nodes, name) -- Add it to the table of liquid nodes
  end
end

for itemname in liquid_swords.liquid_nodes do -- For each liquid node
  local shortname = itemname:match("([^:]+)$") -- Get the itemname without the modname
  local name_from_source = false -- Actual itemname being used for the sword
  if shortname:find("_source") then -- If "_source" is found in the itemname
    name_from_source = name:gsub("_source", "") -- Remove "_source"
  else
    name_from_source = name -- Otherwise keep the itemname
  end
  local description_from_source = core.registered_nodes[itemname].description -- Get the node description
  local description = false -- Actual description for the sword
  if description_from_source:find(" Source") then -- If "Source" is found in the itemname
    description = description_from_source:gsub(" Source", "") .. " Sword" -- Remove "Source"
  else 
    description = description_from_source .. " Sword" -- Otherwise keep the description
  end
  core.register_tool("liquid_swords:sword_"..name_from_source, {
      -- TODO: Add tool properties
      -- NOTE: The texture should be like "liquid_swords_base.png^(liquid_swords_blade.png^SOURCE_TEXTURE)"
  })
end
