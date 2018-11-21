extends Node2D

var lostVal = 0
var spookVal = 0
var shotVal = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func checkLostCollision():
	return 0
	
func checkSpookCollision():
	return 0

func _process(delta):
	if lostVal == 100:
		print("you lost the animal!")
	elif spookVal == 100:
		print("you scared it away")
	elif shotVal == 100:
		print("take the shot!")
	else: #regular course of play
		checkLostCollision()
		checkSpookCollision()
	pass
