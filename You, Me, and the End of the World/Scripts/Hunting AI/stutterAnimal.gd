extends "res://Scripts/Hunting AI/HuntingEnemy.gd"

var moveTime = 61
var lastMove = "none"
var speeds = [6, 4, 2]
var distances = [10,20,30,40,50]
var choices = []

func _ready():
	velocityMultiplier = 4
	pass

func _process(delta):
	#jitter()
	#change directions when near the walls
	if position.x < 40: #near the left wall
		choices = ["right", "up", "down"]
		lastMove = choices[randi()%3]
	elif position.x > 960: #near the right wall
		choices = ["left", "up", "down"]
		lastMove = choices[randi()%3]
	elif position.y < 90: #near the top wall
		choices = ["left", "right", "down"]
		lastMove = choices[randi()%3]
	elif position.y > 575: #near the bottom wall
		choices = ["left", "right", "up"]
		lastMove = choices[randi()%3]
	elif lastMove == "none":
		choices = ["left", "right", "up", "down"]
		lastMove = choices[randi()%4]
	if moveTime < 0:
		#continue in the current direction
		if lastMove == "up":
			runDirection("up")
			lastMove = "up"
		elif lastMove == "left":
			runDirection("left")
			lastMove = "left"
		elif lastMove == "down":
			runDirection("down")
			lastMove = "down"
		else: #if lastMove == "right":
			runDirection("right")
			lastMove = "right"
		velocityMultiplier = speeds[randi()%3] #randomly go one of 3 speeds
		moveTime = distances[randi()%5]#randomly choose to go either a short or long way
	elif moveTime > 60: #first move
		runDirection("right")
		lastMove = "right"
		moveTime = moveTime - 1
	else:
		if lastMove == "up":
			runDirection("up")
		elif lastMove == "left":
			runDirection("left")
		elif lastMove == "down":
			runDirection("down")
		else: #if lastMove == "right":
			runDirection("right")
		moveTime = moveTime - 1
	pass
