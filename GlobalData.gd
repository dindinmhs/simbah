extends Node

var level_config = {
	1: {
		"min_gold": 20,
		"time_limit_minutes": 1,   
		"spawn_delay": 17,
		"npc_speed": 2.5,
		"request_timeout": 30
	},
	2: {
		"min_gold": 40,
		"time_limit_minutes": 2,   
		"spawn_delay": 16,
		"npc_speed": 2.5,
		"request_timeout": 20
	},
	3: {
		"min_gold": 100,
		"time_limit_minutes": 3,   
		"spawn_delay": 15,
		"npc_speed": 2.5,
		"request_timeout": 15
	},
}

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
		{"name": "Beras", "icon": preload("res://assets/icons/beras.png")}
	],
	2: [
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
		{"name": "Temulawak", "icon": preload("res://assets/icons/jamu_temulawak.png")},
		{"name": "Pegagan", "icon": preload("res://assets/icons/pegagan.png")},
		{"name": "Brotowali", "icon": preload("res://assets/icons/brotowali.png")},
	],
	3: [
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
		{"name": "Temulawak", "icon": preload("res://assets/icons/temulawak.png")},
		{"name": "Pegagan", "icon": preload("res://assets/icons/pegagan.png")},
		{"name": "Brotowali", "icon": preload("res://assets/icons/brotowali.png")},
		{"name": "Lempuyang", "icon": preload("res://assets/icons/lempuyang.png")},
		{"name": "Cabai Jawa", "icon": preload("res://assets/icons/cabai_jawa.png")},
		{"name": "Daun Sirih", "icon": preload("res://assets/icons/daun_sirih.png")},
	],
}

var recipes = [
	{
		"level": 1,
		"ingredients": ["Jahe", "Serai", "Kayu Manis", "Gula"],
		"name": "Wedang Jahe",
		"icon": preload("res://assets/icons/wedang_jahe.png"),
		"description": "Menghangatkan tubuh dan meredakan masuk angin.",
		"dialog": ["Aromanya hangat...", "Ini wedang jahe!"]
	},
	{
		"level": 1,
		"ingredients": ["Kunyit", "Gula", "Jeruk Nipis"],
		"name": "Jamu Kunyit Asam",
		"icon": preload("res://assets/icons/jamu_kunyit_asam.png"),
		"description": "Menyegarkan tubuh dan membantu pencernaan.",
		"dialog": ["Asam tapi segar!", "Ini jamu kunyit asam."]
	},
	{
		"level": 1,
		"ingredients": ["Beras", "Kencur", "Gula"],
		"name": "Jamu Beras Kencur",
		"icon": preload("res://assets/icons/jamu_beras_kencur.png"),
		"description": "Memberi stamina dan energi.",
		"dialog": ["Rasanya kuat dan segar.", "Ini beras kencur!"]
	},
	{
		"level": 2,
		"ingredients": ["Temulawak", "Kunyit", "Jahe", "Gula"],
		"name": "Jamu Temulawak",
		"icon": preload("res://assets/icons/jamu_temulawak.png"),
		"description": "Baik untuk pencernaan dan stamina.",
		"dialog": ["Rasa khas temulawak.", "Ini jamu temulawak!"]
	},
	{
		"level": 2,
		"ingredients": ["Pegagan", "Jahe", "Madu"],
		"name": "Jamu Pegagan",
		"icon": preload("res://assets/icons/jamu_pegagan.png"),
		"description": "Meningkatkan fokus dan kesehatan kulit.",
		"dialog": ["Rasa khas pegagan.", "Ini jamu pegagan!"]
	},
	{
		"level": 2,
		"ingredients": ["Brotowali", "Jahe", "Madu"],
		"name": "Jamu Brotowali",
		"icon": preload("res://assets/icons/jamu_brotowali.png"),
		"description": "Meningkatkan daya tahan tubuh.",
		"dialog": ["Pahit tapi berkhasiat.", "Ini jamu pahitan!"]
	},
	{
		"level": 3,
		"ingredients": ["Temulawak", "Kunyit", "Jahe", "Kencur"],
		"name": "Jamu Galian Singset",
		"icon": preload("res://assets/icons/jamu_galian_sinset.png"),
		"description": "Membantu melangsingkan secara tradisional.",
		"dialog": ["Racikan rempah lengkap.", "Ini jamu singset!"]
	},
	{
		"level": 3,
		"ingredients": ["Cabai Jawa", "Temulawak", "Lempuyang"],
		"name": "Jamu Cabe Puyang",
		"icon": preload("res://assets/icons/jamu_cabe_puyang.png"),
		"description": "Meredakan pegal dan rematik.",
		"dialog": ["Pedas hangat...", "Ini cabe puyang!"]
	},
	{
		"level": 3,
		"ingredients": ["Daun Sirih", "Temu Lawak", "Jahe"],
		"name": "Jamu Uyup-uyup",
		"icon": preload("res://assets/icons/jamu_uyup_uyup.png"),
		"description": "Baik untuk pemulihan pasca melahirkan.",
		"dialog": ["Aromanya khas...", "Ini uyup-uyup!"]
	},
]


var npc_needs_by_level := {
	1: [
		{
			"need": "Wedang Jahe",
			"dialog": "Badanku dingin, butuh yang menghangatkan."
		},
		{
			"need": "Jamu Kunyit Asam",
			"dialog": "Perutku nggak enak, pengen yang segar."
		},
		{
			"need": "Jamu Beras Kencur",
			"dialog": "Aku capek banget, perlu tenaga tambahan."
		}
	],

	2: [
		{
			"need": "Jamu Temulawak",
			"dialog": "Pencernaanku lagi nggak bagus, butuh temulawak."
		},
		{
			"need": "Jamu Pegagan",
			"dialog": "Kepalaku mumet, perlu yang bikin fokus."
		},
		{
			"need": "Jamu Brotowali",
			"dialog": "Badanku mudah sakit, perlu jamu pahitan."
		}
	],

	3: [
		{
			"need": "Jamu Galian Singset",
			"dialog": "Pengen tubuh lebih enteng dan fit."
		},
		{
			"need": "Jamu Cabe Puyang",
			"dialog": "Ototku pegal semua, butuh pereda capek."
		},
		{
			"need": "Jamu Uyup-uyup",
			"dialog": "Butuh jamu untuk pemulihan badan."
		}
	]
}


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
	var allowed := []

	for lvl in npc_needs_by_level.keys():
		if lvl <= player_max_unlock_level:
			allowed += npc_needs_by_level[lvl]

	if allowed.is_empty():
		return {"need": "", "dialog": ""}

	var pick = allowed[randi() % allowed.size()]

	return {
		"need": pick["need"],
		"dialog": pick["dialog"]
	}


var player_level : int = 1
var player_max_unlock_level : int = 1
var is_win = true
var last_min_gold := 0
var last_time_limit := 0
