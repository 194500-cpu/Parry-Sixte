extends Node2D

@onready var arrow_scene = preload("res://Scenes/arrow.tscn")
@onready var timer_label: Label = $TimerLabel
@onready var canvas: CanvasLayer = $CanvasLayer
@onready var timer: Timer = $Timer
var wave5 = false
var wave10 = false
var wave20 = false
var wave30 = false
var wave40 = false
var warn5 = false
var warn10 = false
var warn20 = false
var warn30 = false
var warn40 = false
var survival_time: float = 0.0
var is_game_active: bool = true

func _ready() -> void:
	timer.start()


func _process(delta: float) -> void:
	if not is_game_active:
		return
		
	survival_time += delta
	timer_label.text = "%.0f" % survival_time

	if survival_time >= 60.0:
		is_game_active = false
		get_tree().change_scene_to_file("res://Scenes/stage_1_win.tscn")
	var arrow = arrow_scene.instantiate()
	
	if (survival_time >= 5 and !wave5):
		for i in range(2):
			arrow = arrow_scene.instantiate()
			add_child(arrow)
			arrow.setup()
		wave5 = true
	if (survival_time >= 10 and !wave10 and !Global.easy):
		for i in range(2):
			arrow.changespeed(200)
			arrow = arrow_scene.instantiate()
			add_child(arrow)
			arrow.changespeed(200)
			arrow.setup()
		wave10 = true
		#arrow.changespeed(500)
	if (survival_time >= 30 and !wave30):
		arrow = arrow_scene.instantiate()
		add_child(arrow)
		arrow.setup()
		arrow.setscale(2, 2)
		wave30 = true
	if (survival_time >= 40 and !wave40 and !Global.easy):
		for i in range(4):
			arrow = arrow_scene.instantiate()
			add_child(arrow)
			arrow.setup()
			arrow.changespeed(100)
			
		wave40 = true
	if (survival_time >= 20 and !wave20):
		arrow = arrow_scene.instantiate()
		add_child(arrow)
		arrow.setup()
		arrow.changespeed(400)
		arrow.setscale(0.5, 0.5)
		wave20 = true
	
	if (survival_time >= 4 and !warn5):
			warn5 = true
			if is_node_ready():
				canvas.tint()
	if (survival_time >= 9 and !warn10 and !Global.easy):
			warn10 = true
			if is_node_ready():
				canvas.tint()
	if (survival_time >= 19 and !warn20):
			warn20 = true
			if is_node_ready():
				canvas.tint()
	if (survival_time >= 29 and !warn30):
			warn30 = true
			if is_node_ready():
				canvas.tint()
	if (survival_time >= 39 and !warn40 and !Global.easy):
			warn40 = true
			if is_node_ready():
				canvas.tint()
	
		
func _on_timer_timeout() -> void:
	if not is_game_active:
		return
		
	var arrow = arrow_scene.instantiate()
	add_child(arrow)
	arrow.setup()
	if (survival_time < 10):
		timer.wait_time = 1.5
	elif (survival_time < 15):
		timer.wait_time = 1.25
	elif (survival_time < 20):
		arrow.changespeed(750)
	elif (survival_time < 30):
		arrow.changespeed(500)
		timer.wait_time = 2
		arrow.changespeed(500)
		arrow = arrow_scene.instantiate()
		add_child(arrow)
		arrow.setup()
	elif (survival_time < 40):
		timer.wait_time = 1
		arrow.setscale(2,2)
	elif (survival_time < 50):
		timer.wait_time = 1
		arrow.setscale(0.5, 0.5)
	elif (survival_time < 55):
		timer.wait_time = 1.5
	else:
		timer.wait_time = 0.5
	
	timer.start()
