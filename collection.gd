extends Control

var list_container : VBoxContainer
var detail_container : Control
var name_label : Label
var hero_icon : TextureRect
var desc_title : Label
var desc_text : Label
var bahan_list : HBoxContainer

var prev_btn : TextureButton
var next_btn : TextureButton

var page_no : Label
var page_end : Label

var page := 0
var items_per_page := 3

var unlock_level := 0
var max_unlocked_level = 0

func _ready():
	list_container = get_node("Control/BookBackground/ListContainer/ListJamu")
	detail_container = get_node("Control/BookBackground/DetailContainer")
	name_label = detail_container.get_node("NamaJamu")
	hero_icon = detail_container.get_node("Hero/TextureRect")
	desc_title = detail_container.get_node("Description/Title")
	desc_text = detail_container.get_node("Description/Text")
	bahan_list = detail_container.get_node("Bahan/CraftSlots")
	prev_btn = get_node("Control/NextContainer/Prev")
	next_btn = get_node("Control/NextContainer/Next")
	page_no = get_node("Control/BookBackground/ListContainer/Info/PageBox/No")
	page_end = get_node("Control/BookBackground/ListContainer/Info/PageBox/End")

	unlock_level = GlobalData.player_level
	max_unlocked_level = GlobalData.player_max_unlock_level

	prev_btn.pressed.connect(_on_prev_pressed)
	next_btn.pressed.connect(_on_next_pressed)

	build_page()

func get_unlocked_recipes() -> Array:
	var list := []
	for r in GlobalData.recipes:
		list.append(r)
	return list

func build_page():
	for c in list_container.get_children():
		c.queue_free()

	var all = get_unlocked_recipes()
	var start := page * items_per_page
	var end = min(start + items_per_page, all.size())
	var first_valid = null

	for i in range(start, end):
		var recipe : Dictionary = all[i]
		var locked = recipe["level"] > max_unlocked_level

		var container := HBoxContainer.new()
		container.name = "JamuItem"

		var icon := TextureRect.new()
		var label := Label.new()
		var box := VBoxContainer.new()

		icon.texture = recipe["icon"]

		if locked:
			icon.modulate = Color(1,1,1,0.2)
			label.text = "????"
			label.add_theme_color_override("font_color", Color(0.5,0.5,0.5))
		else:
			icon.modulate = Color(1,1,1,1)
			label.text = recipe["name"]
			label.add_theme_color_override("font_color", Color.BLACK)
			if first_valid == null:
				first_valid = recipe

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		label.custom_minimum_size = Vector2(0, 50)

		container.add_child(icon)
		box.alignment = BoxContainer.ALIGNMENT_CENTER
		box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		box.add_child(label)
		container.add_child(box)

		if !locked:
			container.gui_input.connect(func(event):
				if event is InputEventMouseButton and event.pressed:
					show_detail(recipe))
		else:
			container.mouse_filter = Control.MOUSE_FILTER_IGNORE

		list_container.add_child(container)

	update_page_button_state()

	if first_valid != null:
		show_detail(first_valid)

func update_page_button_state():
	var total := get_unlocked_recipes().size()
	var max_page := int(ceil(float(total) / items_per_page)) - 1
	prev_btn.disabled = page <= 0
	next_btn.disabled = page >= max_page
	page_no.text = str(page + 1)
	page_end.text = str(max_page + 1)

func _on_prev_pressed():
	page -= 1
	build_page()

func _on_next_pressed():
	page += 1
	build_page()

func show_detail(recipe: Dictionary):
	name_label.text = recipe["name"]

	if recipe["icon"] != null:
		hero_icon.texture = recipe["icon"]
	else:
		hero_icon.texture = null

	desc_title.text = "Deskripsi"
	desc_text.text = recipe.get("description", "")

	for c in bahan_list.get_children():
		c.queue_free()

	var ingredients : Array = recipe.get("ingredients", [])

	for ing in ingredients:
		var vbox := VBoxContainer.new()
		var icon := TextureRect.new()
		var label := Label.new()

		var ing_data = null
		for category in GlobalData.ingredient_by_level.values():
			for item in category:
				if item["name"] == ing:
					ing_data = item
					break

		if ing_data != null:
			icon.texture = ing_data["icon"]

		label.text = ing
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.add_theme_color_override("font_color", Color.BLACK)
		label.add_theme_font_size_override("font_size", 11)

		vbox.add_child(icon)
		vbox.add_child(label)
		bahan_list.add_child(vbox)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
