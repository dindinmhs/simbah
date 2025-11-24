extends TextureButton

var item_name: String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size = Vector2(64, 64)
	ignore_texture_size = true
	stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
