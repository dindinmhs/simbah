extends Node3D

var inventory : Array = []
var coins : int = 0  

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
@export var stop_area: Area3D

var current_npc : CharacterBody3D = null  

func _ready():
	$SpawnTimer.wait_time = spawn_delay
	$SpawnTimer.start()
	update_coin_display()
	
	btn_accept.pressed.connect(accept_request)
	btn_reject.pressed.connect(reject_request)

func add_to_inventory(recipe:Dictionary):
	inventory.append(recipe)
	result_icon.texture = recipe["icon"]
	result_label.text = recipe["name"]
	print("✔ Ditambahkan ke inventory:", recipe["name"])

func accept_request():
	print("✔ Permintaan diterima")
	dialog_box.visible = false

func reject_request():
	print("❌ Permintaan ditolak")
	remove_coin(5)
	dialog_box.visible = false
	
	if current_npc != null:
		current_npc.queue_free()
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
