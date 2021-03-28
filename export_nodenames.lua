
minetest.register_on_mods_loaded(function()
	minetest.log("warning", "[pandorabox_integration_test] exporting all nodenames")
	local nodenames = {}
	for nodename in pairs(minetest.registered_nodes) do
		table.insert(nodenames, nodename)
	end
	local f = io.open(minetest.get_worldpath() .. "/nodenames.dat", "w")
	f:write(minetest.serialize(nodenames))
	f:close()
end)
