extends CheckButton



func _on_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		Global.easy = true
	else:
		Global.easy = false
