extends "res://Scripts/CombatAI/CombatEnemy.gd"

var threshold = .6
var playerMaxSpeed = 420

onready var player = get_node("../CombatPlayer")
onready var playerHead = get_node("../CombatPlayer/head")
onready var playerTorso = get_node("../CombatPlayer/torso")
onready var bullet = load("res://tscn files/EnemyBullet.tscn")

var bulletSpeed = 1600
var maxDistance = 900

#Weights
var speedWeight = .4
var distanceWeight = .6

func _ready():
	pass

func _physics_process(delta):
	print("Processing")
	if(calcCertainty() > .7 + (.05 * (6 - ammoLeft)) and ammoLeft > 0):
		shoot()
		ammoLeft -= 1

func shoot():
#	print("Shooting")
	var tempBullet = bullet.instance()
	tempBullet.set_position(self.global_position)
	tempBullet.motion = -(self.global_position - playerHead.global_position).normalized()
	self.get_parent().add_child(tempBullet)
	tempBullet.look_at(playerHead.global_position)
	#Determine where the expected point of contact would be
	#Fire bullet
	pass

func calcCertainty():
	#Determine distance from AI
	var distanceToPlayer = (self.global_position - player.global_position).length()

	#determine the movement speed of the player
	#(Less speed / variance will mean a better shot)
	var playerMoveSpeed = abs(player.lastFrameEndSpeed.length())
	if(abs(playerMoveSpeed) > playerMaxSpeed+1):
		playerMaxSpeed = abs(playerMoveSpeed)+1

	#Max player move speed is ~ 400
	var speedVariance = 1 - ((abs(playerMoveSpeed) + 1) / playerMaxSpeed)

	var distanceVariance = 1 - ((distanceToPlayer+1)/ maxDistance)

	# print("Distance: ", distanceToPlayer, "\tPlayer Speed: ", playerMaxSpeed,
	# "\tBulletSpeed: ", bulletSpeed)
	# print("SpeedVariance: ", speedVariance, "\tDistanceVariance: ", distanceVariance)

	return (speedWeight * speedVariance) + (distanceWeight * distanceVariance)

	#Return some calculation of the numbers
