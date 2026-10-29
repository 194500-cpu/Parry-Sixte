extends Control

func _on_button_pressed() -> void:
	if is_node_ready():
		get_tree().change_scene_to_file("res://Scenes/finallevel.tscn")
