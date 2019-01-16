extends "res://Scripts/HuntingEnemy.gd"

var moveTime = 100
var staminaLeft = 100

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if moveTime > 0:
		velocityMultiplier = 5 * (staminaLeft/100)
		runTowards()
		moveTime = moveTime - 1
	else:
		staminaLeft = staminaLeft * .95
		moveTime = staminaLeft
	pass
