extends Node2D

const marginForCameraToZoomOut = 300
#const slowdownOfZoomOut = 5
const maxZoomOutScale = 0.7
const minZoomInScale = 1.0

# class member variables go here, for example:
var isp1Playing
var isp2Playing
var cooldown = true;
var cooldown2 = true;
var timer1 = Timer.new()
var timer2 = Timer.new()
onready var p1_Camera = get_node("walls/player1/Camera2D")
onready var p2_Camera = get_node("walls/player2/Camera2D")
onready var player1 = get_node("walls/player1")
onready var player2 = get_node("walls/player2")
onready var screensize = Vector2(get_viewport().size.x, get_viewport().size.y)
onready var last_player1_pos = player1.global_position
onready var last_player2_pos = player2.global_position

func _ready():
	isp1Playing = true
	isp2Playing = true
	#Handling Timer
	timer1.connect("timeout",self,"_on_timer_timeout")
	timer2.connect("timeout", self, "_on_timer2_timeout")
	add_child(timer1)
	add_child(timer2)
	_start_timer1()
	_start_timer2()
	#Handling Camera
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = (player1.global_position - player2.global_position)/2
	get_viewport().set_canvas_transform(canvas_transform)

#Function to start the timer at 1 seconds
func _start_timer1():
	if !timer1.time_left > 0:
		timer1.wait_time = 1
		timer1.start() #to start

#Function to start the second timer at 1 seconds
func _start_timer2():
	if !timer2.time_left > 0:
		timer2.wait_time = 1
		timer2.start() #to start

#The function to handle when the timer times out
func _on_timer_timeout():
	cooldown = false

func _on_timer2_timeout():
	cooldown2 = false

func _pause():
	print("Game paused")
	get_tree().paused = true
	$pause_popup.update()
	$pause_popup.show()

func _process(delta):
	if Input.is_action_pressed("p1_dropout") and !cooldown:
		if(isp1Playing && isp2Playing):
			cooldown = true
			isp1Playing = false
			_start_timer1()
		elif(!isp1Playing):
			cooldown = true
			isp1Playing = true
			_start_timer1()
	if Input.is_action_pressed("p2_dropout") and !cooldown2:
		if(isp1Playing && isp2Playing):
			cooldown2 = true
			isp2Playing = false
			_start_timer2()
		elif(!isp2Playing):
			cooldown2 = true
			isp2Playing = true
			_start_timer2()
	if Input.is_action_pressed("pause"):
		_pause()
	pass

#func recenter_camera():
#	var canvas_transform = get_viewport().get_canvas_transform()
#	canvas_transform[2] = (player2.global_position - player1.global_position)
#	get_viewport().set_canvas_transform(canvas_transform)

func update_camera():
	#Get the change of p1 and p2's location compared to last update_camera call
	var player_offset = ((last_player1_pos - player1.global_position) + (last_player2_pos - player2.global_position)) / 2
	var player_distance = (player1.global_position - player2.global_position)
	var maxValue = (marginForCameraToZoomOut/((max(abs(player_distance.x), abs(player_distance.y)))))
	if maxValue > minZoomInScale:
		maxValue = minZoomInScale
	elif maxValue < maxZoomOutScale:
		maxValue = maxZoomOutScale
	
	#Update player's last positions to their current position
	last_player1_pos = player1.global_position
	last_player2_pos = player2.global_position
	#Get the current canvas transform
	var canvas_transform = get_viewport().get_canvas_transform()
	#Update the canvas with the player's offset
	canvas_transform[0] = Vector2(maxValue,0)
	canvas_transform[1] = Vector2(0, maxValue)

	player_offset = player_offset
	canvas_transform[2] += player_offset
	get_viewport().set_canvas_transform(canvas_transform)
#	if(maxValue != 1):
#		recenter_camera()
	#DEBUG
#	print('last_player1_pos: ', last_player1_pos)
#	print('last_player2_pos: ', last_player2_pos)
#	print('player1.global_position: ', player1.global_position)
#	print('player2.global_position: ', player2.global_position)
#	print('distance between players: ', (player1.global_position-player2.global_position))
#	print(player_distance.x, ' ' , player_distance.y)
#	print(canvas_transform.get_scale())
#	print(maxValue)
	