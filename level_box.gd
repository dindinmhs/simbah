extends VBoxContainer

@onready var btn_one = $one
@onready var btn_two = $two
@onready var btn_three = $three
@onready var btn_back = $Back

func _ready() -> void:
	update_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_buttons():
	var unlocked = GlobalData.player_max_unlock_level

	btn_one.disabled = unlocked < 1
	btn_two.disabled = unlocked < 2
	btn_three.disabled = unlocked < 3

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_one_pressed() -> void:
	GlobalData.player_level = 1
	get_tree().change_scene_to_file("res://main.tscn")


func _on_two_pressed() -> void:
	GlobalData.player_level = 2
	get_tree().change_scene_to_file("res://main.tscn")


func _on_three_pressed() -> void:
	GlobalData.player_level = 3
	get_tree().change_scene_to_file("res://main.tscn")
