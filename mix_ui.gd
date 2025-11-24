extends Control

@onready var list_container = $"ListContainer"
@onready var crafting_slots : Array[TextureRect] = [
	$"CraftSlots/Slot1",
	$"CraftSlots/Slot2",
	$"CraftSlots/Slot3"
]

var selected_items = ["", "", ""]
var ItemButtonScene = preload("res://ItemButton.tscn")

func _ready():
	build_item_list(GlobalData.player_level)


func build_item_list(level:int):
	# Hapus isi container, bukan kontainernya
	for c in list_container.get_children():
		c.queue_free()

	# Ambil bahan sesuai level
	var ingredients = GlobalData.ingredient_by_level.get(level, [])

	# Buat tombol item
	for item in ingredients:
		var btn = ItemButtonScene.instantiate()
		btn.item_name = item["name"]
		btn.texture_normal = item["icon"]
		btn.pressed.connect(_on_item_pressed.bind(item["name"], item["icon"]))

		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		list_container.add_child(btn)



func _on_item_pressed(item_name:String, icon:Texture2D):
	for i in range(3):
		if selected_items[i] == "":
			selected_items[i] = item_name
			crafting_slots[i].texture = icon
			return


func _on_mix_button_pressed() -> void:
	var result = GlobalData.check_recipe(selected_items)
	if result != "":
		print("Hasil racikan: ", result)
	else:
		print("Tidak ada resep!")
