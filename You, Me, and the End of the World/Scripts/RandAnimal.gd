extends "res://Scripts/HuntingEnemy.gd"

onready var randVal
var moveTime = 0
var lastMove

func _ready():
	velocityMultiplier = 3
	pass

func _process(delta):
	if moveTime <= 0:
		moveTime = 20
		randVal = randi()%4
		if randVal == 0:
			runDirection("up")
			lastMove = "up"
		elif randVal == 1:
			runDirection("left")
			lastMove = "left"
		elif randVal == 2:
			runDirection("down")
			lastMove = "down"
		else:
			runDirection("right")
			lastMove = "right"
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
