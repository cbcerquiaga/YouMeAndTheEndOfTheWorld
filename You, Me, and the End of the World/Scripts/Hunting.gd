extends Node2D

onready var player = get_node("TileMap/Player")
onready var creature = get_node("TileMap/Creature")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func checkJustRightCollision():
	return 0
	
func checkSpookCollision():
	return 0

func _process(delta):
	if player.lostVal == 100:
		print("you lost the animal!")
	elif player.spookVal == 100:
		print("you scared it away")
	elif player.shotVal == 100:
		print("take the shot!")
	else: #regular course of play
		if checkJustRightCollision() == 1:
			player.shotVal+= .5
			player.spookVal-= .25
			player.lostVal-= .25
		elif checkSpookCollision() == 1:
			player.spookVal+= .5
			player.shotVal-= .25
			player.lostVal-= .25
		else: #outside both collision areas
			player.lostVal += .5
			player.shotVal-= .25
			player.spookVal-= .25
	pass
