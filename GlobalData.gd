extends Node

var ingredient_by_level : Dictionary = {
	1: [
		{"name": "Jahe", "icon": preload("res://assets/icons/jahe.png")},
		{"name": "Kunyit", "icon": preload("res://assets/icons/kunyit.png")},
		{"name": "Serai", "icon": preload("res://assets/icons/serai.png")},
		{"name": "Kayu Manis", "icon": preload("res://assets/icons/kayu_manis.png")},
		{"name": "Cengkeh", "icon": preload("res://assets/icons/cengkeh.png")},
		{"name": "Daun Sirih", "icon": preload("res://assets/icons/daun_sirih.png")},
		{"name": "Jeruk Nipis", "icon": preload("res://assets/icons/jeruk.png")},
		{"name": "Madu", "icon": preload("res://assets/icons/madu.png")},
		{"name": "Gula", "icon": preload("res://assets/icons/gula.png")},
		{"name": "Beras", "icon": preload("res://assets/icons/beras.png")},
	]
}

var recipes = [
	{
		"ingredients": ["Jahe", "Serai", "Kayu Manis", "Gula"],
		"name": "Wedang Jahe",
		"icon": preload("res://assets/icons/wedang_jahe.png"),
		"description": "Minuman hangat dari jahe dan rempah-rempah.",
		"dialog": [
			"Aromanya hangat...",
			"Ini wedang jahe!"
		]
	},
	{
		"ingredients": ["Kunyit", "Gula", "Jeruk Nipis"],
		"name": "Jamu Kunyit Asam",
		"icon": preload("res://assets/icons/jamu_kunyit_asam.png"),
		"description": "Jamu segar dari kunyit dan asam.",
		"dialog": [
			"Asam tapi segar!",
			"Ini jamu kunyit asam."
		]
	},
	{
		"ingredients": ["Beras", "Kencur", "Gula"],
		"name": "Jamu Beras Kencur",
		"icon": preload("res://assets/icons/jamu_beras_kencur.png"),
		"description": "Jamu untuk stamina dan tenaga.",
		"dialog": [
			"Rasanya kuat dan segar.",
			"Ini beras kencur!"
		]
	},
]

var npc_needs = [
	{
		"need": "Wedang Jahe",
		"dialog": [
			"Aduh... kepala saya pusing.",
			"Badanku menggigil, butuh yang hangat...",
			"Tolong... buatkan minuman hangat..."
		]
	},
	{
		"need": "Jamu Beras Kencur",
		"dialog": [
			"Aku lelah sekali...",
			"Kakiku pegal-pegal, perlu tenaga ekstra...",
			"Rasanya capek, punya sesuatu untuk stamina?"
		]
	},
	{
		"need": "Jamu Kunyit Asam",
		"dialog": [
			"Aduh... perutku mual...",
			"Kayaknya aku butuh yang segar...",
			"Badanku terasa panas dari dalam..."
		]
	}
]



func check_recipe(items:Array):
	var filtered = items.filter(func(x): return x != "")
	filtered.sort()

	for recipe in recipes:
		var k = recipe["ingredients"].duplicate()
		k.sort()
		if k == filtered:
			return recipe   

	return null

func get_random_npc_request() -> Dictionary:
	var data = npc_needs[randi() % npc_needs.size()]
	var picked_dialog = data["dialog"][randi() % data["dialog"].size()]

	return {
		"need": data["need"],
		"dialog": picked_dialog
	}


var player_level : int = 1
