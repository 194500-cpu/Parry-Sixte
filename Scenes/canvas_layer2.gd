extends CanvasLayer

var curr = 0

@onready var rectc: ColorRect = $ColorRect

func _process(_delta: float) -> void:
	if (curr > 0):
		curr -= 0.01
		rectc.modulate.a = curr

func _ready():
	rectc.modulate.a = 1
	curr = 1
