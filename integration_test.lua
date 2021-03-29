
minetest.log("warning", "[pandorabox_custom] integration-test enabled!")

local fname = minetest.get_modpath("pandorabox_integration_test") .. "/nodenames.dat"
local f = io.open(fname, "r")
local assert_nodes = minetest.deserialize(f:read())

local function test_mobs(callback)
	-- forceload chunk @ 0,0,0
	for x = 0, 16*5, 16 do
		for y = 0, 16*5, 16 do
			for z = 0, 16*5, 16 do
				minetest.forceload_block(vector.new(x, y, z))
			end
		end
	end

	minetest.add_entity({x=10,y=10,z=10}, "mobs_monster:mese_monster")

	minetest.after(5, callback)
end

-- defered integration test function
minetest.register_on_mods_loaded(function()
	minetest.log("warning", "[pandorabox_integration_test] all mods loaded, starting delayed test-function")

	minetest.after(1, function()
		minetest.log("warning", "[pandorabox_integration_test] starting integration test")

		-- check nodes
		local all_nodes_present = true
		for _, nodename in ipairs(assert_nodes) do
			if not minetest.registered_nodes[nodename] and not minetest.registered_aliases[nodename] then
				all_nodes_present = false
				minetest.log("error", "Node not present and not aliased: " .. nodename)
			end
		end

		if not all_nodes_present then
			error("some of the required nodes are not present and not aliased!")
		end

		test_mobs(function()
			-- write success flag
			local data = minetest.write_json({ success = true }, true);
			local file = io.open(minetest.get_worldpath().."/integration_test.json", "w" );
			if file then
				file:write(data)
				file:close()
			end

			minetest.log("warning", "[pandorabox_integration_test] integration tests done!")
			minetest.request_shutdown("success")
		end)
	end)
end)
