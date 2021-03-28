
minetest.register_on_mods_loaded(function()
	minetest.log("warning", "[pandorabox_custom] executing recipe-test")

  local data = {}

  for name in pairs(minetest.registered_nodes) do
    data[name] = minetest.get_all_craft_recipes(name)
  end

  -- jsonStr -> output
  local map = {}
  for name, recipes in pairs(data) do
    for _, recipe in ipairs(recipes) do
      local data_string, err = minetest.write_json(recipe.items)
      if err then
        error(err)
      end

      if map[data_string] and map[data_string] ~= name then
        minetest.log("warning", "recipe collision for " .. name .. "/" ..
          map[data_string] ..
          " recipe: " .. data_string)
      end

      map[data_string] = name
    end
  end

  minetest.log("warning", "[pandorabox_custom] recipe-test done!")
end)
