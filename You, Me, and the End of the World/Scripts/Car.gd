extends KinematicBody2D

var Inventory = preload("res://Scripts/Inventory.gd").new()
onready var area = get_node("Pickup_area")
var player1
var player2

func _ready():
	pass
	
func setPlayer1(player):
	self.player1 = player
	pass
	
func setPlayer2(player):
	self.player2 = player
	pass

func _process(delta):
	if area.overlaps_body(player1) and Input.is_action_just_pressed("p1_action1"):
		#if the player's inventory isn't already open:
			#freeze the player, pop up their inventory
		#popup the player's inventory
		#popup the car inventory
		print("Houston, we have car touch")
	elif area.overlaps_body(player2) and Input.is_action_just_pressed("p2_action1"):
		#same stuff but for player 2
		print("One small step for (a) car, one giant leap for carkind")
	pass