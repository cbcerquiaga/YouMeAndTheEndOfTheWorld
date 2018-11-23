extends Node2D

var crosshair = load("res://Images/Crosshair.png")
onready var player = get_node("TileMap/Player")
onready var creature = get_node("TileMap/Creature")

func _ready():
	Input.set_custom_mouse_cursor(crosshair, 0, Vector2(15, 15))
	pass
	
func checkJustRightCollision():
	var bodies = get_node("TileMap/Creature/Just right").get_overlapping_areas()
	var numBodies = 0
	if !bodies.empty():
		for i in bodies:
			numBodies = numBodies+1
			print(str(numBodies))
	if numBodies > 2 and !checkSpookCollision() == 1:
		return 1
	else:
		return 0
	
func checkSpookCollision():
	var bodies = get_node("TileMap/Creature/Just right").get_overlapping_areas()
	var numBodies = 0
	if !bodies.empty():
		for i in bodies:
			numBodies = numBodies+1
			print(str(numBodies) + "!")
	if numBodies > 1:
		return 1
	else:
		return 0
	
func createBullet(playerPosition):
	if player.ammo > 0:
		print("pew pew")
		player.ammo = player.ammo - 1
		player.shotVal = 0
	else:
		print("I guess you're going to have to tackle this thing")

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
