extends Area2D

@onready var slash_arc: Line2D = $arc
@onready var sound_player = $AudioStreamPlayer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@export var slash_radius: float = 50.0 

var current_tween: Tween = null

func _ready() -> void:
	visible = false
	slash_arc.top_level = true 
	slash_arc.joint_mode = Line2D.LINE_JOINT_ROUND
	if collision_shape:
		collision_shape.disabled = true

func slash() -> void:
	if Global.stamina > 20:
		sound_player.play()
		Global.stamina -= 20
		
		if collision_shape:
			collision_shape.disabled = false
			
		if current_tween and current_tween.is_valid():
			current_tween.kill()
			
		var direction = get_global_mouse_position() - global_position
		var base_angle = direction.angle()
		var level = get_tree().current_scene.name
		var start_angle = 0
		var end_angle = 0
		if (level == "Game"):
			start_angle = base_angle - deg_to_rad(60.0)
			end_angle = base_angle + deg_to_rad(60.0)
		else:
			start_angle = base_angle - deg_to_rad(30.0)
			end_angle = base_angle + deg_to_rad(30.0)

		
		rotation = start_angle
		slash_arc.clear_points()
		visible = true

		current_tween = create_tween()
		current_tween.tween_method(
			func(current_angle: float):
				rotation = current_angle
				var tip_offset = Vector2.RIGHT.rotated(current_angle) * 1.7 * slash_radius
				var tip_global_pos = global_position + tip_offset
				slash_arc.add_point(tip_global_pos), start_angle, end_angle, 0.15).set_trans(Tween.TRANS_QUAD)
		
		current_tween.tween_callback(
			func():
				visible = false
				slash_arc.clear_points()
				if collision_shape:
					collision_shape.disabled = true
		)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("slash") or event.is_action_pressed("slash2"):
		slash()
