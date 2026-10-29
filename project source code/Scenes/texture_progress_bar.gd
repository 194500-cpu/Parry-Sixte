extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.stamina = 100
	
func _process(_delta: float) -> void:
	value = Global.stamina
	if (Global.stamina <= 100):
		Global.stamina += 0.7
