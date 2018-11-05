extends "res://Scripts/CombatAI/CombatEnemy.gd"

var threshold = .6
var playerMaxSpeed = 420
var maxDistance
var minDistance
var rageMinDistance = 15
var rageMaxDistance = 30
var rageCertainty = .45
var middlePoint
var speed = 1.0 #1.0 is the same as the player
var movement
var staticMaxDistance = 315
var staticMinDistance = 300
var staticCertainty = .7
var tauntType = 3
var rage = false

onready var force = Vector2(0, GRAVITY)

onready var player = get_node("../CombatPlayer")
onready var playerHead = get_node("../CombatPlayer/head")
onready var playerTorso = get_node("../CombatPlayer/torso")

#Weights
var speedWeight = .4
var distanceWeight = .6
var weightPerBullet = .05
var randomWeight = .5
var certaintyRandomWeight = .0005

var bulletSpeed = 1600
var maxShootDistance = 900
var certainty = staticCertainty
var totalNumberOfBullets = 6
var randomWaitTime = 1 #Seconds
var bulletCooldown = .2 #Seconds

var randomRecalcTimer = Timer.new()
var randomRecalcTimerCooldownBool = false
var bulletTimer = Timer.new()
var bulletTimerCooldownBool = false

#Function to initiate variables
func _ready():
	maxDistance = staticMaxDistance# must be 3 apart to avoid extreme glitching, 15 to avoid any glitching when forced to move
	minDistance = staticMinDistance
	randomRecalcTimer.wait_time = randomWaitTime
	randomRecalcTimer.connect("timeout", self, "randomRecalcTimerCooldown")
	self.add_child(randomRecalcTimer)
	randomRecalcTimer.start()
	bulletTimer.wait_time = bulletCooldown
	bulletTimer.connect("timeout", self, "bulletTimerCooldown")
	self.add_child(bulletTimer)
	bulletTimer.start()
	pass

func randomRecalcTimerCooldown():
	randomRecalcTimerCooldownBool = false

func bulletTimerCooldown():
	bulletTimerCooldownBool = false

#Times passed is the count of frames 

func implementRand():
	if(not randomRecalcTimerCooldownBool):
		var randomValue = rand_range(-100, 100)
		maxDistance = staticMaxDistance + (randomValue * randomWeight)
		minDistance = staticMinDistance + (randomValue * randomWeight)
		certainty = staticCertainty + (randomValue * certaintyRandomWeight)
		randomRecalcTimerCooldownBool=true
		randomRecalcTimer.wait_time = randomWaitTime
		randomRecalcTimer.start()
		#Todo implement accuracy of the shots based on the AI's skill
#
func _physics_process(delta):
	if Input.is_action_just_pressed("p2_move_left"): #TODO: implement this with signals
		taunted()
	if rage: #the character has become enraged and charges down the player
		print("Prepare to die")
		if(not bulletTimerCooldownBool):
			bulletTimerCooldownBool = true
			bulletTimer.wait_time = bulletCooldown
			bulletTimer.start()
			if(calcCertainty() > rageCertainty + (weightPerBullet * (totalNumberOfBullets - ammoLeft)) and ammoLeft > 0):
				shoot()
				ammoLeft -= 1
				ammoVal = str(ammoLeft)
			elif (totalHealth < 25 and calcCertainty() > .25 and ammoLeft > 0): #about to die, time to get desparate
				shoot()
				ammoLeft -= 1
				ammoVal = str(ammoLeft)
			
		#Physics
		staminaRegen()
		self.move_and_collide(force) #GRAVITY
	
		#Maintaining distance in relation to the player
		movement = Vector2(WALK_MAX_SPEED, 0) * speed
		var distanceToPlayer = (self.global_position - player.global_position)
		if(abs(distanceToPlayer.x) < rageMinDistance):
			if(distanceToPlayer.x > 0):
				move_and_slide(movement)
			else:
				move_and_slide(-movement)
		elif(abs(distanceToPlayer.x) > rageMaxDistance):
			if(distanceToPlayer.x < 0):
				move_and_slide(movement)
			else:
				move_and_slide(-movement)
		
	else: #normal behavior
		#Implementing random into
		#distance Maintained, certainty required, and accuracy
		implementRand()
	
		#Shooting
		if(not bulletTimerCooldownBool):
			bulletTimerCooldownBool = true
			bulletTimer.wait_time = bulletCooldown
			bulletTimer.start()
			if(calcCertainty() > certainty + (weightPerBullet * (totalNumberOfBullets - ammoLeft)) and ammoLeft > 0):
				shoot()
				ammoLeft -= 1
				ammoVal = str(ammoLeft)
			elif (totalHealth < 25 and calcCertainty() > .7 and ammoLeft > 0): #about to die, time to get desparate
				shoot()
				ammoLeft -= 1
				ammoVal = str(ammoLeft)
			
		#Physics
		staminaRegen()
		self.move_and_collide(force) #GRAVITY
	
		#Maintaining distance in relation to the player
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
	var tempBullet = BULLET.instance()
	tempBullet.set_position(self.global_position)
	tempBullet.motion = -(self.global_position - playerHead.global_position).normalized()
	self.get_parent().add_child(tempBullet)
	tempBullet.look_at(playerHead.global_position)
	#Determine where the expected point of contact would be
	#Fire bullet
	pass
	
func taunted():
	if tauntType == 0: #no response
		print("chill out")
	elif tauntType == 1: #taunt back
		print("well ur mum 2 m8")
		#TODO: add a taunt back animation
	else: #tauntType == 2 #rage
		print("You insult me, now preparet o die!")
		rage = true
	

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

	#Returns a calculation of the certainty based on the weights for each of the variances
	return (speedWeight * speedVariance) + (distanceWeight * distanceVariance)
