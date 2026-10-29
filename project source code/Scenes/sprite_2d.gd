extends Sprite2D


func _process(_delta: float) -> void:
	var direction = get_global_mouse_position() - global_position
	var anglemouse = rad_to_deg(direction.angle())
	if (anglemouse > 90 or anglemouse < -90):
		flip_h = true
	else:
		flip_h = false
