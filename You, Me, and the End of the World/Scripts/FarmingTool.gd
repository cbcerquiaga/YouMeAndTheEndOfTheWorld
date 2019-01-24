extends KinematicBody2D

onready var equippedPlayer = 0 #0 means not equipped, 1 is player 1, 2 is player 2
onready var isFacingRight = true
var actionKey
var sprite

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func updateFacingRight(boolean):
	isFacingRight = boolean
	if isFacingRight:
		if sprite != null:
			sprite.set_flip_h(false)
	else: #facing left
		if sprite != null:
			sprite.set_flip_h(true)
			
func equip(player):
	equippedPlayer = player
	if equippedPlayer == 1:
		actionKey = is_action_just_pressed("p1_action1")
	elif equippedPlayer == 2:
		actionKey = is_action_just_pressed("p2_action1")
	
func unEquip():
	equippedPlayer = 0
