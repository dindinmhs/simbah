extends Control

var current_index := 0

var dialog_data = [
	{
		"name": "Dadul",
		"text": "Bertahun-tahun berlalu sejak hari itu.
Toko jamu kecil peninggalan Kakek kini tidak lagi sunyi seperti dulu…
Rak-raknya penuh, pintunya selalu terbuka, dan wangi rempah menyapa setiap orang yang datang.",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Orang-orang dari desa tetangga datang mencari obat herbal, ramuan stamina, hingga jamu dari resep kuno yang hampir hilang.
Apa yang dulu hanya warisan keluarga… kini menjadi tempat yang menolong banyak orang.",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Dan semua itu… dimulai dari keberanian seorang cucu untuk membuka kembali sebuah buku tua.",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Dulu aku takut tidak mampu menjaga semua ini…
Takut tidak bisa seteliti Kakek… tidak bisa sesabar Kakek",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Tapi lihat sekarang… banyak orang datang setiap hari.
Mereka percaya pada jamu buatan toko ini… sama seperti mereka percaya pada Kakek dulu.",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Kakek… aku berhasil, ya?
Toko ini tetap bertahan. Bahkan lebih ramai dari sebelumnya.",
		"foto": "res://assets/gameplay/dialog/dadul_dialog.png"
	},
	{
		"name": "Dadul",
		"text": "Kakek… aku berhasil, ya?
Toko ini tetap bertahan. Bahkan lebih ramai dari sebelumnya.",
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
		get_tree().change_scene_to_file("res://main_menu.tscn")
		return

	show_dialog(current_index)
