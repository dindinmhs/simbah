extends Node

var ingredient_by_level : Dictionary = {
	1: [
		{"name": "jahe", "icon": preload("res://assets/icons/jahe.png")},
		{"name": "kunyit", "icon": preload("res://assets/icons/kunyit.png")},
		{"name": "kencur", "icon": preload("res://assets/icons/kencur.png")},
	]
}

var recipes = {
	["jahe", "kunyit"]: "Jamu Kunyit Asam",
	["jahe", "kencur"]: "Wedang Jahe",
	["kunyit", "kencur"]: "Jamu Kunyit Kencur"
}

func check_recipe(items: Array):
	var filtered = items.filter(func(x): return x != "")
	filtered.sort()

	for key in recipes.keys():
		var k = key.duplicate()
		k.sort()
		if filtered == k:
			return recipes[key]

	return ""

var player_level : int = 1
