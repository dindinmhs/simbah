extends Area3D

var player_in_area := false

@onready var main = get_tree().get_root().get_node("Main")
@onready var hint_label : Label3D = $HintLabel


func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("interact"):
		$Trash.play()
		main.clear_inventory()


func _on_body_entered(body: Node3D) -> void:
	player_in_area = true
	hint_label.visible = true


func _on_body_exited(body: Node3D) -> void:
	player_in_area = false   
	hint_label.visible = false
