extends CharacterBody3D
var SPEED = 0
var state = "straight"   
var turn_direction = Vector3.ZERO
var is_stopped = false
var is_talking = false
@onready var anim = $AnimationPlayer   

func _ready():
	start_turn_after_delay(1.5)

func start_turn_after_delay(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	state = "turn"
	turn_direction = Vector3(0, 0, 1)
	print("NPC mulai belok kanan")

func _physics_process(delta: float) -> void:
	if is_stopped:
		velocity.x = 0
		velocity.z = 0
		move_and_slide()
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if state == "straight":
		var forward = Vector3(1, 0, 0)
		velocity.x = -forward.x * SPEED
		velocity.z = forward.z * SPEED
	elif state == "turn":
		velocity.x = turn_direction.x * SPEED
		velocity.z = -turn_direction.z * SPEED
	
	move_and_slide()
	_handle_animation()
	_handle_rotation(delta)

func _handle_animation():
	if is_stopped and not is_talking:
		if anim.current_animation != "npc_cowo_Idle_1":
			anim.play("npc_cowo_Idle_1")
		return
	
	if is_talking:
		return
	
	if abs(velocity.x) > 0.1 or abs(velocity.z) > 0.1:
		if not anim.is_playing() or anim.current_animation != "npc_cowo_Walking_5":
			anim.play("npc_cowo_Walking_5")
	else:
		if anim.current_animation != "npc_cowo_Idle_1":
			anim.play("npc_cowo_Idle_1")

func _handle_rotation(delta):
	var move_dir = Vector3(velocity.x, 0, velocity.z)
	if move_dir.length() > 0.1:
		move_dir = move_dir.normalized()
		var target_rot = atan2(move_dir.x, move_dir.z)
		rotation.y = lerp_angle(rotation.y, target_rot, 5.0 * delta)

func _on_stop_area_body_entered(body: Node) -> void:
	if body == self:
		is_stopped = true
		is_talking = true
		anim.play("npc_cowo_Talking_2")
		await anim.animation_finished
		is_talking = false
		print("NPC STOP!")

func _on_stop_area_body_exited(body: Node) -> void:
	if body == self:
		is_stopped = false
		print("NPC jalan lagi")
