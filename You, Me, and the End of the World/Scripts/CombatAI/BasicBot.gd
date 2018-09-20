extends "res://Scripts/CombatAI/CombatEnemy.gd"

var threshold = .6
var playerMaxSpeed = 420
var maxDistance
var minDistance
var middlePoint
var speed = 1.0 #1.0 is the same as the player
var movement
onready var player = get_node("../CombatPlayer")
onready var force = Vector2(0, GRAVITY)

onready var playerHead = get_node("../CombatPlayer/head")
onready var playerTorso = get_node("../CombatPlayer/torso")
onready var bullet = load("res://tscn files/EnemyBullet.tscn")

var bulletSpeed = 1600
var maxShootDistance = 900

#Weights
var speedWeight = .4
var distanceWeight = .6

func _ready():
	maxDistance = 315# must be 3 apart to avoid glitching, 15 to avoid any glitching when forced to move
	minDistance = 300
	pass

func _physics_process(delta):
	if(calcCertainty() > .7 + (.05 * (6 - ammoLeft)) and ammoLeft > 0):
		shoot()
		ammoLeft -= 1
		ammoVal = str(ammoLeft)
	elif (totalHealth < 25 and calcCertainty() > .7 and ammoLeft > 0): #about to die, time to get desparate
		shoot()
		ammoLeft -= 1
		ammoVal = str(ammoLeft)
	staminaRegen()
	self.move_and_collide(Vector2(0,500)) #GRAVITY
	movement = Vector2(WALK_MAX_SPEED, 0) * speed
	var distanceToPlayer = (self.global_position - player.global_position)
	if(abs(distanceToPlayer.x) < minDistance):
		if(distanceToPlayer.x > 0):
			move_and_slide(movement)
		else:
			move_and_slide(-movement)
	elif(abs(distanceToPlayer.x) > maxDistance):
		if(distanceToPlayer.x < 0):
			move_and_slide(movement)
		else:
			move_and_slide(-movement)

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

	var distanceVariance = 1 - ((distanceToPlayer+1)/ maxShootDistance)

	# print("Distance: ", distanceToPlayer, "\tPlayer Speed: ", playerMaxSpeed,
	# "\tBulletSpeed: ", bulletSpeed)
	# print("SpeedVariance: ", speedVariance, "\tDistanceVariance: ", distanceVariance)

	return (speedWeight * speedVariance) + (distanceWeight * distanceVariance)

	#Return some calculation of the numbers
