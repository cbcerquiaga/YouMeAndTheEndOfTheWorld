extends "res://Scripts/Hunting AI/HuntingEnemy.gd"

var state
var plots

func _ready():
	state = "searching"
	pass
	
func setPlots(newPlots):
	plots = newPlots
	
func lookForFood():
	pass
	
func huntDownTheFood():
	pass

func _process(delta):
	#the hoe is too close, need to run
	if location.x - position.x < 60 and location.x - position.x > -60:
		if location.y - position.y < 60 and location.y - position.y > -60:
			state = "running"
	if state == "searching":
		lookForFood()
	elif state == "running":
		runDirectlyAway()
	elif state == "tracking":
		huntDownTheFood()
	pass
