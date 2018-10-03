extends Control

# class member variables go here, for example:
var isp1Playing
var isp2Playing
var exploreMouse = load("res://Images/ExploreCursor.png")
onready var camera = get_node("walls/playerTracking/Camera")

#Timers handle the popup cooldown, it is required to not spam
var dropoutCoolDownPlayer1 = Timer.new()
var dropoutCoolDownPlayer2 = Timer.new()
var dropoutCooldownPlayer1 = false
var dropoutCooldownPlayer2 = false

#Handles inventory popup, cooldown is required to not spam the screen
var invPopupTimerP1 = Timer.new()
var invPopupTimerP2 = Timer.new()
var player1InventoryPopupCooldown = false
var player2InventoryPopupCooldown = false

onready var player1 = get_node("walls/player1")
onready var player2 = get_node("walls/player2")
onready var screensize = Vector2(get_viewport().size.x, get_viewport().size.y)

onready var inventoryScreenP1 = get_node("/root/Root/HUDControl/InventoryScreenP1")


func _ready():
	camera.make_current()
	isp1Playing = true
	isp2Playing = true
	Input.set_custom_mouse_cursor(exploreMouse)
	#Handling dropout Timers
	dropoutCoolDownPlayer1.connect("timeout", self, "_on_timer_timeout" )
	dropoutCoolDownPlayer2.connect("timeout", self, "_on_timer2_timeout")
	add_child(dropoutCoolDownPlayer1)
	add_child(dropoutCoolDownPlayer2)
	_start_timer1()
	_start_timer2()

	#Handles Inventory popup timer
	invPopupTimerP1.connect("timeout", self, "_player1_Inventory_cooldown_reset")
	invPopupTimerP2.connect("timeout", self, "_player2_Inventory_cooldown_reset")
	add_child(invPopupTimerP1)
	add_child(invPopupTimerP2)
	_start_p1_Inventory_Cooldown()
	_start_p2_Inventory_Cooldown()

	#connect to inventory signals
	inventoryScreenP1.connect("drop_item_signal", self, "p1_drop_item")
	
	#Handling Camera
#	update_camera()

#Function to start the timer at 1 seconds
func _start_timer1():
	if !dropoutCoolDownPlayer1.time_left > 0:
		dropoutCoolDownPlayer1.wait_time = 1
		dropoutCoolDownPlayer1.start() #to start

#Function to start the second timer at 1 seconds
func _start_timer2():
	if !dropoutCoolDownPlayer2.time_left > 0:
		dropoutCoolDownPlayer2.wait_time = 1
		dropoutCoolDownPlayer2.start() #to start

#The function to handle when the timer times out
func _on_timer_timeout():
	dropoutCoolDownPlayer1.stop()
	dropoutCooldownPlayer1 = false

#The function to handle when the second time times out
func _on_timer2_timeout():
	dropoutCoolDownPlayer2.stop()
	dropoutCooldownPlayer2 = false

#Function to start the inventory Popup Timer for player1 at 1 second
func _start_p1_Inventory_Cooldown():
	if !invPopupTimerP1.time_left > 0:
		invPopupTimerP1.wait_time = 1
		invPopupTimerP1.start() #to start
		player1InventoryPopupCooldown = true

#Function to start the inventory Popup Timer for player2 at 1 second
func _start_p2_Inventory_Cooldown():
	if !invPopupTimerP2.time_left > 0:
		invPopupTimerP2.wait_time = 1
		invPopupTimerP2.start() #to start
		player2InventoryPopupCooldown = true

#Is called each time the invPopupTimerP1 runs out of time
func _player1_Inventory_cooldown_reset():
	invPopupTimerP1.stop()
	player1InventoryPopupCooldown = false

#Is called each time the invPopupTimerP2 runs out of time
func _player2_Inventory_cooldown_reset():
	invPopupTimerP2.stop()
	player2InventoryPopupCooldown = false

#Handles pausing
func _pause():
	get_tree().paused = true
	var pause_popup = get_node("/root/Root/HUDControl/pause_popup")
	#CanvasItem * (CanvasLayer+GlobalCanvas+Stretch) * position
	pause_popup.set_position(camera.get_camera_screen_center() - (screensize/2))
	pause_popup.show()

#Handles showing/hiding player2's inventory and freezing the player
func _inventory1():
	var zoomedOut = player1.getZoom()
	inventoryScreenP1.setKeys("p1_move_left","p1_move_right","p1_move_up","p1_move_down", "p1_action1", "p1_move_left", "p1_inventory")
	if !zoomedOut:
		inventoryScreenP1.set_position(camera.get_camera_screen_center() - Vector2(screensize.x/1.5, screensize.y/3.2))
		inventoryScreenP1.set_scale(Vector2(0.7,0.7))
	else:
		inventoryScreenP1.set_position(camera.get_camera_screen_center() - Vector2(screensize.x/1.001, screensize.y/2.16))
		inventoryScreenP1.set_scale(Vector2(1.05,1.05))
	if(!player1.isFrozen):
		inventoryScreenP1.show()
		inventoryScreenP1.loadInventory(player1.getInventory().itemList)
	else:
		inventoryScreenP1.hide()
	player1.isFrozen = !player1.isFrozen

#Handles showing/hiding player2's inventory and freezing the player
func _inventory2():
	var zoomedOut = player1.getZoom()
	var inventoryScreenP2 = get_node("/root/Root/HUDControl/InventoryScreenP2")
	inventoryScreenP2.setKeys("p2_move_left","p2_move_right","p2_move_up","p2_move_down", "p2_action1", "p2_move_right", "p2_inventory")
	if !zoomedOut:
		inventoryScreenP2.set_position(camera.get_camera_screen_center() - Vector2(20, screensize.y/3.2))
		inventoryScreenP2.set_scale(Vector2(0.7,0.7)) 
	else:
		inventoryScreenP2.set_position(camera.get_camera_screen_center() - Vector2(20, screensize.y/2.16))
		inventoryScreenP2.set_scale(Vector2(1.05,1.05))
	if(!player2.isFrozen):
		inventoryScreenP2.show()
	else:
		inventoryScreenP2.hide()
	player2.isFrozen = !player2.isFrozen

func _process(delta):

	#Handles player1 dropping out
	#Player1 can dropout so long as cooldown isn't active, and player2 is playing
	if Input.is_action_pressed("p1_dropout") and !dropoutCooldownPlayer1:
		if(isp1Playing && isp2Playing):
			dropoutCooldownPlayer1 = true
			isp1Playing = false
			_start_timer1()
		elif(!isp1Playing):
			dropoutCooldownPlayer1 = true
			isp1Playing = true
			_start_timer1()

	#Handles player2 dropping out
	#Player2 can dropout so long as cooldown2 isn't active, and player1 is playing
	if Input.is_action_pressed("p2_dropout") and !dropoutCooldownPlayer2:
		if(isp1Playing && isp2Playing):
			dropoutCooldownPlayer2 = true
			isp2Playing = false
			_start_timer2()
		elif(!isp2Playing):
			dropoutCooldownPlayer2 = true
			isp2Playing = true
			_start_timer2()

	#Handle pausing
	if Input.is_action_pressed("pause"):
		_pause()
	#Handles the UI for the inventory for player1
	if Input.is_action_pressed("p1_inventory") and !player1InventoryPopupCooldown:
		_inventory1()
		_start_p1_Inventory_Cooldown()
	#Handles the UI for the inventory for player2
	if Input.is_action_pressed("p2_inventory") and !player2InventoryPopupCooldown:
		_inventory2()
		_start_p2_Inventory_Cooldown()
	pass
	
func p1_drop_item():
	print("signal caught by scene manager")
	player1.dropItem(0)

#function called whenever the camera should be adjusted
#func update_camera():
##	#Get the current canvas transform
#	var canvas_transform = get_viewport().get_canvas_transform()
#
##	#Update the canvas with the center of the two players being the center of the viewport
#	canvas_transform[2] = (-(player1.global_position + player2.global_position)/(2) + (screensize/(2)))
#
#	#Applies the transform
#	get_viewport().set_canvas_transform(canvas_transform)
