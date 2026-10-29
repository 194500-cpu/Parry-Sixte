extends Area2D

var moving = true
var arrowspeed = 500
@onready var animated_sprite = $animation
@onready var sound_player = $AudioStreamPlayer2D
var scalefactor = Vector2(1, 1)
func setup():
	position = randomcoord()
	look_at(Vector2(394.5, 394.5))
	scale = scalefactor

func invis():
	animated_sprite.invis()

func _ready():
	animated_sprite.play("default")
	
func _physics_process(delta: float) -> void:
	if moving:
		position += Vector2.RIGHT.rotated(rotation) * arrowspeed * delta
	if position.x < -200 or position.x > 1000 or position.y < -200 or position.y > 1000:
		queue_free()
func changespeed(speed):
	arrowspeed = speed
	if is_node_ready():
		animated_sprite.sped()

func randomcoord():
	var num = randf()
	var xc = 0
	var yc = 0
	
	
	if (num < 0.5):
		if (num < 0.25):
			yc = 0
			xc = randi_range(0, 789)
		else:
			yc = 789
			xc = randi_range(0, 789)
	else:
		if (num < 0.75):
			xc = 0
			yc = randi_range(0, 789)
		else:
			xc = 789
			yc = randi_range(0, 789)
	return Vector2(xc, yc)
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword") or area.name == "Sword":
		set_deferred("monitoring", false)
		moving = false
		$CollisionShape2D.set_deferred("disabled", true)
		var tween = create_tween()
		rotation += deg_to_rad(85)
		sound_player.play()
		hit_stop(0.1, 0.01)
		tween.tween_property(self, "scale", Vector2.ZERO, 1)
		tween.tween_callback(queue_free)	


func _on_body_entered(body: Node2D) -> void:
	var level = get_tree().current_scene.name
	Engine.time_scale = 1.0
	
	var scene = get_tree().current_scene

	if scene.has_meta("changing_scene"):
		return
	if body.is_in_group("player") or body.name == "Player":
		if (level == "Game"):
			if is_node_ready():
				get_tree().change_scene_to_file.call_deferred("res://Scenes/game_over.tscn")
		else:
			if is_node_ready():
				get_tree().change_scene_to_file.call_deferred("res://Scenes/game_over_2.tscn")


func hit_stop(duration, slow_scale) -> void:
	Engine.time_scale = slow_scale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0
	
func setscale(sizex, sizey):
	scalefactor = Vector2(sizex, sizey)
	scale = Vector2(sizex, sizey)
	if is_node_ready():
		animated_sprite.scaled()
