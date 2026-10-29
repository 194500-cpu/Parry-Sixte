extends AnimatedSprite2D

var invisible = false
var count = 0.5
var increment = -0.05
func _process(_delta: float) -> void:
	if (invisible):
		if (count <= 0):
			increment = 0.05
		elif (count >= 1):
			increment = -0.05
		modulate.a = count
		count += increment


func invis():
	invisible = true
	modulate.r = 255

func scaled():
	modulate.r = 128
	modulate.g = 128

func sped():
	modulate.b = 255
