extends KinematicBody2D

onready var popup = get_node("Popup")
onready var area = get_node("pickup_area")
var player1
var player2
var inventory1
var inventory2

signal carInventory

func _ready():
	pass
	
func setPlayer1(player):
	self.player1 = player
	pass
	
func setPlayer2(player):
	self.player2 = player
	pass

func setInventory1(inventory):
	self.inventory1 = inventory
	pass
	
func setInventory2(inventory):
	self.inventory2 = inventory
	pass

func _process(delta):
	if area.overlaps_body(player1) and Input.is_action_just_pressed("p1_action1"):
		emit_signal("carInventory1")
		#popup the player's inventory
		#popup the car inventory
		print("Houston, we have car touch")
	elif area.overlaps_body(player2) and Input.is_action_just_pressed("p2_action1"):
		#same stuff but for player 2
		emit_signal("carInventory2")
		print("One small step for (a) car, one giant leap for carkind")
	pass