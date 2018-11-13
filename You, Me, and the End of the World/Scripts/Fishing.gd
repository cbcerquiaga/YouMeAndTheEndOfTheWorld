extends Node2D

#specific information for this fishing scene, need to be passed as parameters
var depth = 100
var ecosystem = "river"
var fishFrequency = 10
var obstacleFrequency = 10
var obstacleDistance = 10
var legendaryFishChance = 0
var availableFish = ["bass", "goldfish", "koi"]
var legendaryFish = "giant gar"

#standard with every fishing scene
onready var camera = get_node("PlayerTracker/Camera2D")
onready var player1 = get_node("TileMap/Player1")
onready var player2 = get_node("TileMap/Player2")

func _ready():
	camera.make_current()
	pass

func _process(delta):
#if one player catches a fish but the other hasn't, disable its movement and let it get off screen
	if player1.caughtFish and !player2.caughtFish:
		print("player 1 has a fish, but let player 2 keep going")
	elif player2.caughtFish and !player1.caughtFish:
		print("player 2 has a fish, but let player 1 keep going")
	else:
		#TODO: this doesn't need to be called every frame
		if get_node("PlayerTracker").hasReachedBottom: #go up
			player1.goingUp = true
			player2.goingUp = true
		else:
			player1.goingUp = false
			player2.goingUp = false
#if both players catch a fish or they reach the bottom, start scrolling up
#if a player has no fish and strikes an obstacle, delete them from the scene
#if a player is going down, has a fish, and strikes an obstacle, freeze them in place and have the camera follow the other player
#if a player is going up, has a fish, and strikes an obstacle, drop the fish
	pass
