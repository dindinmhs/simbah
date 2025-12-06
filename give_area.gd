# give_area.gd
extends Area3D

var player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		check_give()

func check_give():
	var main = get_tree().root.get_node("Main")
	
	# Cek apakah ada request yang aktif
	if not main.is_request_active:
		print("❌ Tidak ada permintaan yang aktif!")
		return
	
	if main.inventory.size() == 0:
		print("❌ Kamu belum membuat jamu!")
		return
	
	if main.current_npc == null:
		print("❌ Tidak ada NPC yang meminta jamu!")
		return
	
	var given = main.inventory[0]
	var jamu_name = given["name"]
	var npc = main.current_npc
	
	# Stop timer karena jamu sudah diberikan
	main.stop_request_timer()
	
	if jamu_name == npc.need_jamu:
		print("✔ BENAR! Jamu diberikan:", jamu_name)
		main.add_coin(10)
	else:
		print("❌ SALAH! NPC meminta:", npc.need_jamu, " tapi kamu beri:", jamu_name)
		main.remove_coin(5)
	
	# NPC keluar dengan belok kanan 2x
	npc.continue_walking()
	main.current_npc = null
	main.clear_inventory()

func _on_body_entered(body):
	if body.name == "Player": 
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
