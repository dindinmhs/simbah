extends Area3D

var player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		check_give()

func check_give():
	var main = get_tree().root.get_node("Main")
	
	# Cek apakah ada inventory
	if main.inventory.size() == 0:
		print("❌ Kamu belum membuat jamu!")
		return
	
	# Cek apakah ada NPC yang sedang menunggu
	if main.current_npc == null:
		print("❌ Tidak ada NPC yang meminta jamu!")
		return
	
	var given = main.inventory[0]
	var jamu_name = given["name"]
	var npc = main.current_npc
	
	if npc.has_variable("need_jamu"):
		var npc_need = npc.need_jamu
		
		if jamu_name == npc_need:
			print("✔ BENAR! Jamu diberikan:", jamu_name)
			main.add_coin(10)
		else:
			print("❌ SALAH! NPC meminta:", npc_need, " tapi kamu beri:", jamu_name)
			main.remove_coin(5)
		
		# Hapus NPC setelah diberi jamu
		npc.queue_free()
		main.current_npc = null
		
		# Bersihkan inventory player
		main.clear_inventory()

func _on_body_entered(body):
	if body.name == "Player": 
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
