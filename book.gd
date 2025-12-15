extends Area3D

var player_in_area = false

func _ready() -> void:
	pass

func _open_ui():
	var parent = get_parent()
	var mix_menu = parent.get_node("MixMenu")
	var gameplay_ui = parent.get_node("UI")
	var book_ui = parent.get_node("bookUI")

	mix_menu.visible = false
	gameplay_ui.visible = false
	book_ui.visible = true
	
	parent.pause_game()

func _close_ui():
	var parent = get_parent()
	var mix_menu = parent.get_node("MixMenu")
	var gameplay_ui = parent.get_node("UI")
	var book_ui = parent.get_node("bookUI")

	mix_menu.visible = false
	gameplay_ui.visible = true
	book_ui.visible = false
	
	parent.resume_game()

func _process(delta: float) -> void:
	var ui = get_parent().get_node("bookUI")
	if player_in_area and Input.is_action_just_pressed("interact"):
		_open_ui()
	elif player_in_area and Input.is_action_just_pressed("close") and ui.visible == true:
		_close_ui()

func _on_body_entered(body: Node3D) -> void:
	player_in_area = true
	$HintLabel.visible = true

func _on_body_exited(body: Node3D) -> void:
	player_in_area = false
	$HintLabel.visible = false
