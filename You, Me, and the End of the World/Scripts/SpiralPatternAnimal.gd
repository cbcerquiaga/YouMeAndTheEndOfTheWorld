extends "res://Scripts/HuntingEnemy.gd"

var moveTime = 61
var lastMove
var distances = [60, 20]

func _ready():
	velocityMultiplier = 4
	pass

func _process(delta):
	if moveTime < 0:
		#move counterclockwise either a short or long distance
		if lastMove == "up":
			runDirection("left")
			lastMove = "left"
		elif lastMove == "left":
			runDirection("down")
			lastMove = "down"
		elif lastMove == "down":
			runDirection("right")
			lastMove = "right"
		else: #if lastMove == "right":
			runDirection("up")
			lastMove = "up"
		moveTime = distances[randi()%2] #randomly choose to go either a short or long way
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
