extends Node2D

const marginForCameraToZoomOut = 300
#const slowdownOfZoomOut = 5
const maxZoomOutScale = 0.7
const minZoomInScale = 1.0

# class member variables go here, for example:
var isp1Playing
var isp2Playing
var exploreMouse = load("res://Images/ExploreCursor.png")

#Timers handle the popup cooldown, it is required to not spam
var timer1 = Timer.new()
var timer2 = Timer.new()
var cooldown = false
var cooldown2 = false

#Handles inventory popup, cooldown is required to not spam the screen
var invPopupTimerP1 = Timer.new()
var invPopupTimerP2 = Timer.new()
var player1InventoryPopupCooldown = false
var player2InventoryPopupCooldown = false

onready var player1 = get_node("walls/player1")
onready var player2 = get_node("walls/player2")
onready var screensize = Vector2(get_viewport().size.x, get_viewport().size.y)


func _ready():
	isp1Playing = true
	isp2Playing = true
	Input.set_custom_mouse_cursor(exploreMouse)
	#Handling dropout Timers
	timer1.connect("timeout", self, "_on_timer_timeout" )
	timer2.connect("timeout", self, "_on_timer2_timeout")
	add_child(timer1)
	add_child(timer2)
	_start_timer1()
	_start_timer2()
	
	#Handles Inventory popup timer
	invPopupTimerP1.connect("timeout", self, "_player1_Inventory_cooldown_reset")
	invPopupTimerP2.connect("timeout", self, "_player2_Inventory_cooldown_reset")
	add_child(invPopupTimerP1)
	add_child(invPopupTimerP2)
	_start_p1_Inventory_Cooldown()
	_start_p2_Inventory_Cooldown()
	

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
	timer1.stop()
	cooldown = false

#The function to handle when the second time times out
func _on_timer2_timeout():
	timer2.stop()
	cooldown2 = false

#Function to start the timer at 1 seconds
func _start_p1_Inventory_Cooldown():
	if !invPopupTimerP1.time_left > 0:
		invPopupTimerP1.wait_time = 1
		invPopupTimerP1.start() #to start
		player1InventoryPopupCooldown = true

#Function to start the second timer at 1 seconds
func _start_p2_Inventory_Cooldown():
	if !invPopupTimerP2.time_left > 0:
		invPopupTimerP2.wait_time = 1
		invPopupTimerP2.start() #to start
		player2InventoryPopupCooldown = true

func _player1_Inventory_cooldown_reset():
	invPopupTimerP1.stop()
	player1InventoryPopupCooldown = false
	
func _player2_Inventory_cooldown_reset():
	invPopupTimerP2.stop()
	player2InventoryPopupCooldown = false

func _pause():
	get_tree().paused = true
	$pause_popup.rect_global_position = (-(player1.global_position + player2.global_position)/(2) + (screensize/(2)))
	$pause_popup.update()
	$pause_popup.show()
	
func _inventory1():
	#TODO: adjust position to the right half of the screen if both p
	if(!player1.isFrozen):
		$InventoryScreenP1.rect_global_position = Vector2(0, screensize.y / 4) + Vector2(-(screensize.x / 14), 0)
		$InventoryScreenP1.show()
	else:
		$InventoryScreenP1.hide()
	player1.isFrozen = !player1.isFrozen

func _inventory2():
	#TODO: adjust position to the right half of the screen if both p
	if(!player2.isFrozen):
		$InventoryScreenP2.rect_global_position = Vector2(0, screensize.y / 4) + Vector2(screensize.x / 1.8, 0)
		$InventoryScreenP2.show()
	else:
		$InventoryScreenP2.hide()
	player2.isFrozen = !player2.isFrozen

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
	if Input.is_action_pressed("p1_inventory") and !player1InventoryPopupCooldown:
		_inventory1()
		_start_p1_Inventory_Cooldown()
	if Input.is_action_pressed("p2_inventory") and !player2InventoryPopupCooldown:
		_inventory2()
		_start_p2_Inventory_Cooldown()
		pass
	pass

func update_camera():
#	#Get the current canvas transform
	var canvas_transform = get_viewport().get_canvas_transform()
#	#Update the canvas with the center of the two players being the center of the viewport
	canvas_transform[2] = (-(player1.global_position + player2.global_position)/(2) + (screensize/(2)))
	#Applies the transform
	get_viewport().set_canvas_transform(canvas_transform)
