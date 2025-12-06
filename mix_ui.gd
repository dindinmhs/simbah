extends Control

@onready var list_container = $"ListContainer"
@onready var crafting_slots : Array[TextureRect] = [
	$"CraftSlots/Slot1",
	$"CraftSlots/Slot2",
	$"CraftSlots/Slot3",
	$"CraftSlots/Slot4",
]

@onready var main = get_tree().get_root().get_node("Main")

var selected_items = ["", "", "", ""]
var ItemButtonScene = preload("res://ItemButton.tscn")

func _ready():
	build_item_list(GlobalData.player_level)

func build_item_list(level:int):
	for c in list_container.get_children():
		c.queue_free()

	var ingredients = GlobalData.ingredient_by_level.get(level, [])

	for item in ingredients:
		var vbox = VBoxContainer.new()

		var icon_rect = TextureRect.new()
		icon_rect.texture = item["icon"]

		var label = Label.new()
		label.text = item["name"]
		label.autowrap_mode = TextServer.AUTOWRAP_WORD 
		label.add_theme_font_size_override("font_size", 10)
		label.add_theme_color_override("font_color", Color.BLACK)
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		vbox.add_child(icon_rect)
		vbox.add_child(label)

		vbox.gui_input.connect(func(event):
			if event is InputEventMouseButton and event.pressed:
				_on_item_pressed(item["name"], item["icon"])
		)

		list_container.add_child(vbox)


func _on_item_pressed(item_name:String, icon:Texture2D):
	for i in range(4):
		if selected_items[i] == "":
			selected_items[i] = item_name
			crafting_slots[i].texture = icon
			return

func _on_mix_button_pressed() -> void:
	var result = GlobalData.check_recipe(selected_items)

	if result != null:
		print("Hasil racikan:", result["name"])

		$"iconJamu".texture = result["icon"]
		$"namaJamu".text = result["name"]

		main.add_to_inventory(result)

		selected_items = ["", "", "", ""]
		for slot in crafting_slots:
			slot.texture = null

	else:
		print("Tidak ada resep!")
