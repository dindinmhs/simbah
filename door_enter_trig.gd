extends Area3D

# Tentukan node target langsung di sini (atau via get_node di _ready) 
var rotate_angle_deg = 90.0
var rotate_duration = 0.5
var stay_duration = 2.0

var original_rotation : Vector3
var target_node : Node3D


func _ready() -> void:
	target_node = get_node("/root/Main/DoorEnter")


func _on_body_entered(body: Node3D) -> void:
	if target_node == null:
		return

	$Bell.play()
	original_rotation = target_node.rotation

	var target_rot = target_node.rotation
	target_rot.y += deg_to_rad(rotate_angle_deg)

	var tween = create_tween()

	tween.tween_property(
		target_node,
		"rotation",
		target_rot,
		rotate_duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	tween.tween_interval(stay_duration)

	tween.tween_property(
		target_node,
		"rotation",
		original_rotation,
		rotate_duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
