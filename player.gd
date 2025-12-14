extends CharacterBody3D


const SPEED = 5.0
const CAM_SPEED = 150


func _physics_process(delta: float) -> void:

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if is_on_floor() and input_dir != Vector2(0,0):
		$AnimationPlayer.play("player_Walking_5")
	elif is_on_floor() and input_dir == Vector2(0,0):
		$AnimationPlayer.play("player_Breathing Idle_1")
	
	if Input.is_action_pressed("cam_left"):
		$CameraController.rotate_y(deg_to_rad(-CAM_SPEED * delta))
	if Input.is_action_pressed("cam_right"):
		$CameraController.rotate_y(deg_to_rad(CAM_SPEED * delta))
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction = ($CameraController.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if input_dir != Vector2(0,0):
		$AuxScene.rotation_degrees.y = $CameraController.rotation_degrees.y - rad_to_deg(input_dir.angle()) + 90
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	$CameraController.position = lerp($CameraController.position, position, 0.15)
	
	var cam_forward = -$CameraController.global_transform.basis.z
	
	var front_wall = get_tree().current_scene.get_node("Floor/FrontWall")
	var back_wall = get_tree().current_scene.get_node("Floor/BackWall")
	var left_wall = get_tree().current_scene.get_node("Floor/LeftWall")
	var right_wall = get_tree().current_scene.get_node("Floor/RightWall")

	var forward_z = cam_forward.z  
	var forward_x = cam_forward.x  
	
	var threshold = 0.5  
	
	front_wall.visible = true
	back_wall.visible = true
	left_wall.visible = true
	right_wall.visible = true
	
	if forward_z > -threshold:  
		back_wall.visible = false
	elif forward_z < threshold:  
		front_wall.visible = false
		
	if forward_x > threshold:  
		right_wall.visible = false
	elif forward_x < -threshold:  
		left_wall.visible = false
