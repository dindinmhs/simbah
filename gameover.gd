extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalData.is_win :
		$BgMenu/Status.text = "Anda Menang"
		$BgMenu/MenuBox/Start.text = "Lanjutkan"
	else :
		$BgMenu/Status.text = "Anda Kalah"
		$BgMenu/MenuBox/Start.text = "Ulangi"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
