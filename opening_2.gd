extends Control

var current_index := 0

var dialog_data = [
	{
		"name": "Dadul",
		"text": "Kakek… rasanya masih sulit percaya kalau Kakek benar-benar sudah pergi.",
		"foto": "res://assets/gameplay/dialog/dadul_kecil_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Banyak orang datang hari ini. Mereka semua cerita tentang bagaimana Kakek pernah menolong mereka… Aku baru sadar… betapa besar arti Kakek untuk desa ini.",
		"foto": "res://assets/gameplay/dialog/dadul_kecil_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Rumah akan terasa sangat berbeda tanpa Kakek. Tanpa suara Kakek… tanpa tawa Kakek… tanpa aroma tanaman yang selalu Kakek keringkan.",
		"foto": "res://assets/gameplay/dialog/dadul_kecil_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Maaf, Kek… aku belum siap melepas. Tapi aku akan pulang dulu. Banyak hal yang harus kupikirkan…",
		"foto": "res://assets/gameplay/dialog/dadul_kecil_dialog.png"
	},
]



@onready var dialog_text = $Dialog/dialogText
@onready var dialog_name = $Dialog/name
@onready var dialog_foto = $Dialog/Foto


func _ready() -> void:
	show_dialog(current_index)


func show_dialog(index: int) -> void:
	if index >= dialog_data.size():
		return  

	var d = dialog_data[index]

	dialog_name.text = d["name"]
	dialog_text.text = d["text"]

	var tex = load(d["foto"])
	if tex:
		dialog_foto.texture = tex


func _on_next_pressed() -> void:
	current_index += 1

	if current_index >= dialog_data.size():
		get_tree().change_scene_to_file("res://opening_3.tscn")
		return

	show_dialog(current_index)
