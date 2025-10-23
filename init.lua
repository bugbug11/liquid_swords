local liquid_swords = {} -- Table for storing runtime mod data
liquid_swords.liquid_nodes = {} -- Table for storing liquid nodes
for name, _ in pairs(core.registered_nodes) do -- For every registered node,
  if core.get_node_group(name, "liquid") then -- If the node is in the liquid group,
    table.insert(liquid_swords.liquid_nodes, name) -- Add it to the table of liquid nodes
  end
end

