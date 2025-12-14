extends Control

var current_index := 0

var dialog_data = [
	{
		"name": "Dadul",
		"text": "Sejak kecil, aku tumbuh di rumah ini… tempat aroma daun kering dan rempah selalu memenuhi udara.",
		"foto": "res://assets/gameplay/dialog/dadul_kecil_dialog.png"
	},
	{
		"name": "Mbah",
		"text": "Lihat ini, daun kemangi yang sudah kering. Baunya menenangkan, bukan?",
		"foto": "res://assets/gameplay/dialog/mbah_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Iya, Kek. Aku suka aroma rumah kita. Selalu hangat… selalu nyaman.",
		"foto": "res://assets/gameplay/dialog/dadul_kecil_dialog.png"
	},
	{
		"name": "Mbah",
		"text": "Rumah ini sederhana, tapi penuh cerita. Suatu hari, kalau aku sudah tak ada… aku ingin kamu tetap menjaganya.",
		"foto": "res://assets/gameplay/dialog/mbah_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Hah? Kakek bicara apa sih… Kakek kan kuat. Aku masih ingin belajar banyak dari Kakek.",
		"foto": "res://assets/gameplay/dialog/dadul_kecil_dialog.png"
	},
	{
		"name": "Mbah",
		"text": "Haha… ya, ya. Kamu memang keras kepala. Tapi itu bagus. Dunia butuh orang sepertimu.",
		"foto": "res://assets/gameplay/dialog/mbah_dialog.png"
	}
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
		get_tree().change_scene_to_file("res://opening_2.tscn")
		return

	show_dialog(current_index)
