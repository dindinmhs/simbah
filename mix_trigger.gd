extends Area3D

var player_in_area = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _open_ui():
	var ui = get_parent().get_node("MixMenu")
	ui.visible = true

func _close_ui():
	var ui = get_parent().get_node("MixMenu")
	ui.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ui = get_parent().get_node("MixMenu")
	if player_in_area and Input.is_action_just_pressed("interact"):
		_open_ui()
	elif player_in_area and Input.is_action_just_pressed("close") and ui.visible == true:
		_close_ui()

func _on_body_entered(body: Node3D) -> void:
	player_in_area = true


func _on_body_exited(body: Node3D) -> void:
	player_in_area = false
