extends Control

var current_index := 0

var dialog_data = [
	{
		"name": "Dadul",
		"text": "Kakek, aku akan melanjutkan toko ini. Aku akan membuat jamu dan obat herbal yang menolong banyak orang seperti dulu.",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Hm… buku resep warisan Kakek. Tulisan tangannya… masih jelas seperti dulu.",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Kakek selalu sangat teliti. Catatan perbandingan bahan… cara merebus… semuanya lengkap.",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Kakek sering bilang… ‘setiap tanaman bisa jadi obat kalau digunakan dengan benar. Aku ingat betul kata-kata itu.",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Kakek… mulai hari ini, aku akan menjaga toko jamu herbal ini. Aku akan meneruskan apa yang sudah Kakek mulai.",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
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
		Ost.stream = load("res://assets/sound/ost1.mp3")
		Ost.play()
		get_tree().change_scene_to_file("res://main.tscn")
		return

	show_dialog(current_index)
