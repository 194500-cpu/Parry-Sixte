extends Button



func _on_pressed() -> void:
	if is_node_ready():
		get_tree().change_scene_to_file("res://Scenes/instructions.tscn")
