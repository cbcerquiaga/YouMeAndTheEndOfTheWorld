extends Node2D

#specific information for this fishing scene, need to be passed as parameters
var depth = 100
var sceneWidth = 16
var ecosystem = "river"
var fishFrequency = 10
var obstacleFrequency = 50
var obstacleLength = 10
var legendaryFishChance = 0
var availableFish = ["bass", "goldfish", "koi"]
var legendaryFish = "giant gar"

#standard with every fishing scene
onready var camera = get_node("PlayerTracker/Camera2D")
onready var player1 = get_node("TileMap/Player1")
onready var player2 = get_node("TileMap/Player2")
onready var obstacles = get_node("Obstacles")

func _ready():
	camera.make_current()
	generateObstacles()
	pass

func generateObstacles():
	var currentLength = 0
	var obstacleType = 0 #0 = left wall, 1 = right wall, 2 = center wall, 3 = vertical divider
	for i in range (obstacleFrequency):
		currentLength = randi()%obstacleLength + 1 #length of the obstacle is an int between 1 and obstacleLength
		obstacleType = randi()%3 #type of the obstacle is an int between 0 and 3
		if obstacleType == 0:
			createLeftWall(currentLength)
		elif obstacleType == 1:
			createRightWall(currentLength)
		elif obstacleType == 2:
			createCenterWall(currentLength)
		else: #obstacleType == 3:
			createVerticalWall(currentLength)

func createLeftWall(currentLength):
	print("left wall with length " + str(currentLength))
	var height = randi()%depth
	for i in range(currentLength):
		obstacles.set_cell(i, height,1)
		
func createRightWall(currentLength):
	print("right wall with length " + str(currentLength))
	var height = randi()%depth
	for i in range(currentLength):
		obstacles.set_cell(sceneWidth - i, height,1)
		
#redundant w/ left wall function?
func createCenterWall(currentLength):
	print("center wall with length " + str(currentLength))
	var height = randi()%depth
	var offset = (sceneWidth - currentLength)/2
	for i in range(currentLength):
		obstacles.set_cell(i, height,1)
		
func createVerticalWall(currentLength):
	print("vertical wall with length " + str(currentLength))
	var x = randi()%sceneWidth
	for i in range(currentLength):
		obstacles.set_cell(x, i,1)
		
func _pause():
	print("Game paused")
	get_tree().paused = true
	#$pause_popup.update()
	get_node("PlayerTracker/pause_popup").show()
	


func _process(delta):
	if Input.is_action_pressed("pause"):
		_pause()
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
