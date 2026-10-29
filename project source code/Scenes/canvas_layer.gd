extends CanvasLayer

var curr = 0

func _process(_delta: float) -> void:
	if (curr > 0):
		curr -= 0.01
		rectc.modulate.a = curr

@onready var rectc: ColorRect = $ColorRect
func tint():
	rectc.modulate.a = 0.4
	curr = 0.4
