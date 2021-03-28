local MP = minetest.get_modpath("pandorabox_integration_test")

dofile(MP.."/export_nodenames.lua")

if minetest.settings:get_bool("enable_integration_test") then
	dofile(MP.."/integration_test.lua")
end

if minetest.settings:get_bool("enable_recipe_test") then
	dofile(MP.."/recipe_test.lua")
end

