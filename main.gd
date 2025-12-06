# main.gd
extends Node3D

var inventory : Array = []
var coins : int = 0  
var request_timer : Timer = null
var is_request_active : bool = false

@onready var gameplay_ui = $"UI/Control"
@onready var result_icon = $"UI/Control/JamuActive/Icon"
@onready var result_label = $"UI/Control/JamuActive/Name"
@onready var coin_label = $"UI/Control/Info/Coin"  
@onready var dialog_box = $"UI/Control/Dialog"
@onready var btn_accept = $"UI/Control/Dialog/acceptButton"  
@onready var btn_reject = $"UI/Control/Dialog/rejectButton"  

@export var npc_cowo: PackedScene = load("res://npc_cowo.tscn")
@export var spawn_delay := 10 
@export var npc_speed := 2.5
@export var request_timeout := 60.0  # 1 menit dalam detik
@export var stop_area: Area3D

var current_npc : CharacterBody3D = null  

func _ready():
	$SpawnTimer.wait_time = spawn_delay
	$SpawnTimer.start()
	update_coin_display()
	
	btn_accept.pressed.connect(accept_request)
	btn_reject.pressed.connect(reject_request)
	
	# Buat timer untuk request timeout
	request_timer = Timer.new()
	add_child(request_timer)
	request_timer.timeout.connect(_on_request_timeout)

func _process(delta):
	if is_request_active and request_timer:
		var time_left = request_timer.time_left
		print("⏱️ Waktu tersisa: %.1f detik" % time_left)

func add_to_inventory(recipe:Dictionary):
	inventory.append(recipe)
	result_icon.texture = recipe["icon"]
	result_label.text = recipe["name"]
	print("✔ Ditambahkan ke inventory:", recipe["name"])

func accept_request():
	print("✔ Permintaan diterima")
	dialog_box.visible = false
	is_request_active = true
	
	# Start timer 1 menit
	request_timer.start(request_timeout)
	print("⏱️ Timer dimulai: %.0f detik" % request_timeout)

func reject_request():
	print("❌ Permintaan ditolak")
	remove_coin(5)
	dialog_box.visible = false
	is_request_active = false
	
	if current_npc:
		current_npc.reject_and_leave()
	
	current_npc = null

func _on_request_timeout():
	print("⏱️ WAKTU HABIS! NPC pergi tanpa jamu")
	is_request_active = false
	
	if current_npc:
		current_npc.continue_walking()
		current_npc = null

func add_coin(amount: int):
	coins += amount
	update_coin_display()
	print("💰 +", amount, " coins | Total:", coins)

func remove_coin(amount: int):
	coins -= amount
	if coins < 0:
		coins = 0
	update_coin_display()
	print("💸 -", amount, " coins | Total:", coins)

func update_coin_display():
	if coin_label:
		coin_label.text = "Coins: " + str(coins)

func clear_inventory():
	inventory = []
	result_icon.texture = null
	result_label.text = ""

func stop_request_timer():
	if request_timer and request_timer.time_left > 0:
		request_timer.stop()
		is_request_active = false

func spawn_npc():
	var npc = npc_cowo.instantiate()
	$Spawner.add_child(npc)
	npc.global_position = $Spawner.global_position
	npc.SPEED = npc_speed
	
	if stop_area:
		stop_area.body_entered.connect(func(body): _on_npc_entered_stop_area(body, npc))
		stop_area.body_exited.connect(npc._on_stop_area_body_exited)
		print("✓ NPC connected to StopArea")
	else:
		print("✗ StopArea belum di-assign di Inspector!")

func _on_npc_entered_stop_area(body: Node, npc: CharacterBody3D):
	if body == npc:
		current_npc = npc  
		npc._on_stop_area_body_entered(body)

func _on_spawn_timer_timeout() -> void:
	spawn_npc()
