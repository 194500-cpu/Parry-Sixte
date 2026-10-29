extends Node2D

@onready var arrow_scene = preload("res://Scenes/arrow.tscn")
@onready var timer_label: Label = $TimerLabel
@onready var timer: Timer = $Timer
@onready var canvas: CanvasLayer = $CanvasLayer
var spawn = true
var defaultinvis = false
var survival_time: float = 0.0
var is_game_active: bool = true
var arrow

func _ready() -> void:
	timer.start()
	Engine.time_scale = 1.0


var warn20 = false
var warn50 = false
var warn55 = false
var warn10 = false

func _process(delta: float) -> void:
	if not is_game_active:
		return
		
	survival_time += delta
	timer_label.text = "%.0f" % survival_time

	if survival_time >= 60.0:
		is_game_active = false
		get_tree().change_scene_to_file("res://Scenes/finalwin.tscn")

	if (survival_time >= 19 and !warn20):
		warn20 = true
		if is_node_ready():
				canvas.tint()
	if (survival_time >= 49 and !warn50):
		warn50 = true
		if is_node_ready():
				canvas.tint()
	if (survival_time >= 54 and !warn55):
		warn55 = true
		if is_node_ready():
				canvas.tint()
	if (survival_time >= 9 and !warn10):
		warn10 = true
		if is_node_ready():
				canvas.tint()
							
				
						
func _on_timer_timeout() -> void:
	if not is_game_active:
		return

	arrow = arrow_scene.instantiate()
		
	if (spawn):	
		add_child(arrow)
		arrow.setup()
		if (defaultinvis):
			arrow.invis()
			
			
	if (survival_time < 25):
		spawn = false
	else:
		spawn = true
			
	if (survival_time < 10):
		timer.wait_time = 0.55
		defaultinvis = false
		spawn = true
	elif (survival_time < 15):
		timer.wait_time = 1
		defaultinvis = false
		arrow.changespeed(750)
		if (!Global.easy):
			arrow.setscale(1.5, 0.9)
		spawn = true
	elif (survival_time < 22 and survival_time > 20):
		spawn = false
		if (!Global.easy):
			timer.wait_time = 0.3
		else:
			timer.wait_time = 0.75
		arrow = arrow_scene.instantiate()
		add_child(arrow)
		arrow.setup()
		arrow.invis()
	elif (survival_time < 30 and survival_time > 22):
		spawn = true
		timer.wait_time = 1.5
		arrow = arrow_scene.instantiate()
		add_child(arrow)
		arrow.setup()
		arrow.setscale(1.5,1.5)
		if (!Global.easy):
			arrow = arrow_scene.instantiate()
			add_child(arrow)
			arrow.setup()
			arrow.invis()
	elif (survival_time > 30 and survival_time < 35):
		spawn = true
		arrow.setscale(1.5, 1.5)
		timer.wait_time = 0.5
		arrow.changespeed(400)
	elif (survival_time < 40 and survival_time > 35):
		spawn = false
		timer.wait_time = 0.1
	elif (survival_time > 40 and survival_time < 45):
		spawn = true
		arrow.setscale(0.7, 0.7)
		timer.wait_time = 0.5
	elif (survival_time < 50 and survival_time > 45):
		spawn = false
	elif (survival_time > 50 and survival_time < 55):
		spawn = true
		timer.wait_time = 1.5
		if (!Global.easy):
			arrow.changespeed(1200)
		else:
			arrow.changespeed(1000)
	elif (survival_time > 55):
		spawn = false
		timer.wait_time = 5
		if (!Global.easy):
			for i in range(3):
				arrow = arrow_scene.instantiate()
				add_child(arrow)
				arrow.setup()
				arrow.invis()
				arrow.setscale(0.9, 0.9)
				arrow.changespeed(600)
		else:
			arrow = arrow_scene.instantiate()
			add_child(arrow)
			arrow.setup()
			arrow.invis()
			arrow.setscale(0.9, 0.9)
			arrow.changespeed(600)
		
		
	timer.start()
