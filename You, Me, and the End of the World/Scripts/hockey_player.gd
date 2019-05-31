extends KinematicBody2D

#the 3 player skills
var speedTrait
var hittingTrait
var fightingTrait
#player AI attributes
var aggressiveness #chance of instigating a fight
var discipline #chance of getting instigated

const BIGHITSPEED = 100 #arbitrary for now
const RATTLECHANCE = 5 #arbitrary for now


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func checkHit(opp_hitting, opp_speed):
	if opp_speed > BIGHITSPEED:
		return true
	elif opp_hitting > hittingTrait:
		return true
	else:
		return false
		
func isRattled(oppAgressiveness):
	if oppAgressiveness > discipline:
		var check = randi() % RATTLECHANCE
		if check == 0:
			return true
		else:
			return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
