extends CharacterBody3D


const SPEED = 5.0
const CAM_SPEED = 150


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if is_on_floor() and input_dir != Vector2(0,0):
		$AnimationPlayer.play("player_Walking_5")
	elif is_on_floor() and input_dir == Vector2(0,0):
		$AnimationPlayer.play("player_Breathing Idle_1")
	
	if Input.is_action_pressed("cam_left"):
		$CameraController.rotate_y(deg_to_rad(-CAM_SPEED * delta))
	if Input.is_action_pressed("cam_right"):
		$CameraController.rotate_y(deg_to_rad(CAM_SPEED * delta))
	
	# Add the gravity.
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
