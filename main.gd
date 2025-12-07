extends Node3D

var inventory : Array = []
var coins : int = 0
var request_timer : Timer = null
var is_request_active : bool = false
var current_npc : CharacterBody3D = null
var show_timer := false
var time_left := 0.0     # Dalam detik (float untuk akurasi)
var min_gold := 0

@onready var gameplay_ui = $"UI/Control"
@onready var result_icon = $"UI/Control/JamuActive/IconBox/Icon"
@onready var result_label = $"UI/Control/JamuActive/NameBox/Name"
@onready var coin_label = $"UI/Control/Info/Box/CoinBox/Coin"
@onready var dialog_box = $"UI/Control/Dialog"
@onready var btn_accept = $"UI/Control/Dialog/acceptButton"
@onready var btn_reject = $"UI/Control/Dialog/rejectButton"
@onready var timeout_box : HBoxContainer = $"UI/Control/Timer"
@onready var timeout_label : Label = $"UI/Control/Timer/Timeout"
@onready var day_label : Label = $"UI/Control/Info/Box/DayBox/Day"
@onready var time_label : Label = $"UI/Control/Info/Box/TimeBox/Time"
@onready var gold_min_label : Label = $"UI/Control/Info/Box/CoinBox/Min"

@export var npc_cowo: PackedScene = load("res://npc_cowo.tscn")
@export var spawn_delay := 10
@export var npc_speed := 2.5
@export var request_timeout := 15.0
@export var stop_area: Area3D

func _ready():
	var lv = GlobalData.player_level
	var cfg = GlobalData.level_config[lv]

	min_gold = cfg["min_gold"]

	# Config sudah dalam menit, konversi ke detik
	var minutes = cfg["time_limit_minutes"]
	time_left = float(minutes * 60)  # Konversi menit ke detik

	spawn_delay = cfg["spawn_delay"]
	npc_speed = cfg["npc_speed"]
	request_timeout = cfg["request_timeout"]

	GlobalData.last_min_gold = min_gold
	GlobalData.last_time_limit = int(time_left)

	day_label.text = str(lv)
	time_label.text = format_time(time_left)
	gold_min_label.text = str(min_gold)

	$SpawnTimer.wait_time = spawn_delay
	$SpawnTimer.start()

	update_coin_display()

	btn_accept.pressed.connect(accept_request)
	btn_reject.pressed.connect(reject_request)

	# Timer request NPC
	request_timer = Timer.new()
	add_child(request_timer)
	request_timer.timeout.connect(_on_request_timeout)

	timeout_box.visible = false


func _process(delta):
	# Kurangi waktu
	time_left -= delta
	if time_left < 0:
		time_left = 0

	# Update tampilan timer dengan format MM:SS
	time_label.text = format_time(time_left)

	# Cek jika waktu habis
	if time_left <= 0:
		check_end_condition()

	# Update timer permintaan NPC
	if show_timer and request_timer:
		var t = max(0, request_timer.time_left)
		timeout_label.text = str(int(ceil(t)))

		if t <= 0:
			timeout_box.visible = false
			show_timer = false


func format_time(seconds: float) -> String:
	var total_secs = int(seconds)
	var minutes = total_secs / 60
	var secs = total_secs % 60
	return "%02d:%02d" % [minutes, secs]


func check_end_condition():
	if coins >= min_gold and GlobalData.player_level < GlobalData.level_config.size():
		GlobalData.is_win = true

		var next_level = GlobalData.player_level + 1
		if next_level > GlobalData.player_max_unlock_level:
			GlobalData.player_max_unlock_level = next_level
		get_tree().change_scene_to_file("res://gameover.tscn")
	else:
		GlobalData.is_win = false
		get_tree().change_scene_to_file("res://gameover.tscn")


func add_to_inventory(recipe:Dictionary):
	inventory.append(recipe)
	result_icon.texture = recipe["icon"]
	result_label.text = recipe["name"]


func accept_request():
	dialog_box.visible = false
	is_request_active = true
	show_timer = true
	timeout_box.visible = true

	timeout_label.text = str(int(request_timeout))
	request_timer.start(request_timeout)


func reject_request():
	remove_coin(5)
	dialog_box.visible = false
	is_request_active = false
	timeout_box.visible = false
	show_timer = false

	if current_npc:
		current_npc.reject_and_leave()
	current_npc = null


func _on_request_timeout():
	timeout_box.visible = false
	show_timer = false
	is_request_active = false

	if current_npc:
		current_npc.continue_walking()
	current_npc = null


func add_coin(amount: int):
	coins += amount
	update_coin_display()


func remove_coin(amount: int):
	coins -= amount
	if coins < 0:
		coins = 0
	update_coin_display()


func update_coin_display():
	if coin_label:
		coin_label.text = str(coins)


func clear_inventory():
	inventory = []
	result_icon.texture = preload("res://assets/gameplay/racik.png")
	result_label.text = "Racik Jamu"


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


func _on_npc_entered_stop_area(body: Node, npc: CharacterBody3D):
	if body == npc:
		current_npc = npc
		npc._on_stop_area_body_entered(body)


func _on_spawn_timer_timeout() -> void:
	spawn_npc()
