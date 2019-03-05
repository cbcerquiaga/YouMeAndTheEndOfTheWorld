extends "res://Scripts/HuntigEnemy.gd"

var state

func _ready():
	state = "searching"
	pass

func _process(delta):
	#the hoe is too close, need to run
	if location.x - position.x < 60 and location.x - position.x > -60:
		if location.y - position.y < 60 and location.y - position.y > -60:
			state = "running"
	pass
