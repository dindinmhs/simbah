extends Node3D

@export var npc_cowo: PackedScene = load("res://npc_cowo.tscn")
@export var spawn_delay := 4.0 
@export var npc_speed := 2.5

func _ready():
	$SpawnTimer.wait_time = spawn_delay
	$SpawnTimer.start()

func spawn_npc():
	var npc = npc_cowo.instantiate()
	add_child(npc)
	npc.global_position = global_position
	npc.SPEED = npc_speed
	
	# Langsung ambil StopArea dari scene tree
	var stop_area = get_node("")
	if stop_area:
		stop_area.body_entered.connect(npc._on_stop_area_body_entered)
		stop_area.body_exited.connect(npc._on_stop_area_body_exited)
		print("✓ NPC connected to StopArea")
	else:
		print("✗ StopArea tidak ditemukan!")
		
func _on_spawn_timer_timeout() -> void:
	spawn_npc()
