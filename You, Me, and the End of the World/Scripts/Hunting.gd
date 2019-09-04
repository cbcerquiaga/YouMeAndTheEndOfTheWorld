extends Node2D

var crosshair = load("res://Images/Crosshair.png")
onready var player = get_node("TileMap/Player")
onready var creature = get_node("TileMap/Creature")

func _ready():
	Input.set_custom_mouse_cursor(crosshair, 0, Vector2(15, 15))
	pass
	
func checkJustRightCollision():
	if (getXDist() < creature.justRightDist and getXDist() > (1-creature.justRightDist)) and (getYDist() < creature.justRightDist and getYDist() > (1 - creature.justRightDist)) and !checkSpookCollision() == 1:
		return 1
	else:
		return 0
	
func checkSpookCollision():
	if (getXDist() < creature.spookDist and getXDist() > (1-creature.spookDist)) and (getYDist() < creature.spookDist and getYDist() > (1 - creature.spookDist)):
		print("too close")
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
		
func _pause():
	print("Game paused")
	get_tree().paused = true
	#$pause_popup.update()
	$pause_popup.show()

func _process(delta):
	if Input.is_action_pressed("pause"):
		_pause()
	creature.setHunterLocation(player.position)
	passBulletsInfo()
	if creature.health <= 0:
		print("You got it!")
		#randomize what the player actually gets
		#leave the minigame
	if player.lostVal == 100:
		lost()
		#print("you lost the animal!")
	elif player.spookVal == 100:
		spooked()
		#print("you scared it away")
	else: #regular course of play
		if checkSpookCollision() == 1:
			player.spookVal+= .5
			player.shotVal-= .25
			player.lostVal-= .25
		elif checkJustRightCollision() == 1:
			player.shotVal+= .5
			player.spookVal-= .25
			player.lostVal-= .25
		else: #outside both collision areas
			player.lostVal += .5
			player.shotVal-= .25
			player.spookVal-= .25
	pass
	
#when the animal is lost, end the game and send the player out without being able to find them again
func lost():
	#TODO: show the player some kind of text explaining what happened
	#TODO: transfer back to the world the player was in and keep persistent changes
	get_tree().change_scene("res://tscn files/World1.tscn")
	pass
	
#when the animal is spooked, end the game but put the player near more footprints
func spooked():
	#TODO: show the player some kind of text explaining what happened
	#TODO: transfer back to the world the player was in and keep persistent changes
	get_tree().change_scene("res://tscn files/World1.tscn")
	pass
	
func getXDist():
	return player.position.x - creature.position.x
	
func getYDist():
	return player.position.y - creature.position.y
	
func passBulletsInfo():
	print("bullets are getting their info")
	if player.bulletsFired.size() > 0:
		for i in range(0, player.bulletsFired.size() - 1):
			player.bulletsFired[i].loadCreature(creature)
			player.bulletsFired[i].loadCreatureSprite(get_node("TileMap/Creature/Sprite"))