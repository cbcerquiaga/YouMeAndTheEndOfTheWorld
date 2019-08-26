extends KinematicBody2D

#boolean player states for both AI and human controlled players
var isStanding #true for standing, false for fallen
var isFighting #true for fighting, false for playing
var playable = true #whether or not the player can play in the current game
#the 3 player skills
var speedTrait
var hittingTrait
var fightingTrait
#player AI attributes
var aggressiveness #chance of instigating a fight
var discipline #chance of getting instigated
var chase_tendency #desire to chase the puck
var hit_tendency #desire to chase players to hit them
var defense_tendency #desire to stay back on defense

const BIGHITSPEED = 100 #arbitrary for now
const RATTLECHANCE = 5 #arbitrary for now

onready var health = 100
var playerFighting #the player actively being fought

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
