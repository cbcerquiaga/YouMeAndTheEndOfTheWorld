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
onready var player1 = get_node("walls/player1")
onready var player2 = get_node("walls/player2")
onready var screensize = Vector2(get_viewport().size.x, get_viewport().size.y)


func _ready():
	isp1Playing = true
	isp2Playing = true
	#Handling Timer
	timer1.connect("timeout", self, "_on_timer_timeout" )
	timer2.connect("timeout", self, "_on_timer2_timeout")
	add_child(timer1)
	add_child(timer2)
	_start_timer1()
	_start_timer2()
	#Handling Camera
	update_camera()

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

#The function to handle when the second time times out
func _on_timer2_timeout():
	cooldown2 = false

func _pause():
	get_tree().paused = true
	$pause_popup.rect_global_position = (-(player1.global_position + player2.global_position)/(2) + (screensize/(2)))
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

func update_camera():
#	#Get the current canvas transform
	var canvas_transform = get_viewport().get_canvas_transform()
#	#Update the canvas with the center of the two players being the center of the viewport
	canvas_transform[2] = (-(player1.global_position + player2.global_position)/(2) + (screensize/(2)))
	#Applies the transform
	get_viewport().set_canvas_transform(canvas_transform)
