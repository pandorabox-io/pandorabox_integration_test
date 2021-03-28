unused_args = false

globals = {
}

read_globals = {
	"minetest",

	-- Stdlib
	string = {fields = {"split"}},
	table = {fields = {"copy", "getn"}},

	-- Minetest
	"vector", "ItemStack",
	"dump", "screwdriver"
}
