extends KinematicBody2D

#jump variables and constants
const JUMP_VELOCITY = 4.5
const JUMP_CUT_VAL = 1
const GRAVITY = 0.1
const CROUCH_GRAVITY = 2.5
var timeHeld = 0
var timeForFullJump = 0.1
var motion = Vector2()

#combat-affecting variables
var isCrouched = false
var isInAir = false
var isGrappling = false #if the player and enemy are grappling,
	#the player and enemy are stuck together with whoever has more
	#strength having greater control over movement. In this situation,
	# both can maneuver for a body slam, and the lunge, heavy, and
	# ranged attacks won't work anymore
var meleeDamageBonus #based on perks
var rangedSpreadBonus #based on perks
var rangedWeapon #check the player's inventory for an equipped
	#ranged weapon. This affects fire rate, spread, projectile speed,
	#how many shots can be fired, damage, and bonus affects
var meleeWeapon #check the player's inventory for an equipped
	#melee weapon. This affects reach, damage, grappling, blocking,
	#speed, and bonus affects
var ammoLeft
	
#player status variables
var headHealth = 100
var torsoHealth = 100
var armHealth = 100
var legHealth = 100
var totalHealth = 100 #heavily weights head and torso health
var bleedRate
var stamina = 100 #the player's current stamina level
var maxStamina = 100 #the maximum stamina the player can have with their current fitness
var staminaRegen = .25 #how quickly the player's stamina regenerates
var agility
var strength


func _ready():
	#ready stuff
	pass

#func jump(motion):
#	#increase jump height depending on duration of jump hold and player's agility
#	#play jump animation
#	#stop jump if player releases button or max height reached
#	#accelerate towards the ground
#	#if isCrouched, increase groundward acceleration
#	#stop upon reaching the ground
#	motion.y = -JUMP_VELOCITY #negative because the velocity is going up
#	return motion
	
#func jump_cut(motion):
#	if motion.y < -JUMP_CUT_VAL:
#		 motion.y = -JUMP_CUT_VAL
#	return motion

func calculateHealth():
	if headHealth == 0: #if the head is gone, the player is dead
		return 0
	elif torsoHealth == 0: #if the torso is gone, the player is dead
		return 0
	else: #weight head and torso health more than limb health
		var tempHealth = (headHealth + torsoHealth)*2
		tempHealth = tempHealth + armHealth + legHealth
		tempHealth = tempHealth/6
		return tempHealth
	pass

func _physics_process(delta):
#	var motion = Vector2(0,0)
	if Input.is_action_just_pressed("p1_move_up"):#up arrow
		if stamina >=20:
			motion.y = -JUMP_VELOCITY
			stamina -= 20
			print("jump")
		
	 #if Input.is_action_just_released("p1_move_up"):
    	#motion = jump_cut(motion)

	if Input.is_action_pressed("p1_move_bottom"):#down arrow
		#play crouch animation
		#isCrouched = true #check this before doing other movements
		#reset isCrouched upon release
		print("crouch")

	if Input.is_action_pressed("p1_move_left"):#left arrow
		#if isInAir or isCrouched, reduce amount the player can affect motion
		motion += Vector2(-1, 0)

	if Input.is_action_pressed("p1_move_right"):#right arrow
		#if isInAir or isCrouched, reduce amount the player can affect motion
		motion += Vector2(1, 0)

	if Input.is_action_pressed("p2_move_left"):#A
		#if isCrouched, use crouch grab animation
		#if isInAir, use tackle animation
		#else use regular animation
		#check if the enemy is reached
		#if yes, check the player's grapple skill and apply chance
		#if this is passed, set isGrappling to true for the player and enemy
		print("grab")

	if Input.is_action_pressed("p2_action2"):#E
		#check to see if the player is in the air or crouched
		#play appropriate animation
		#check to see if the enemy is hit, where, and apply damage
		#reduce stamina
		print("head melee attack")

	if Input.is_action_pressed("p2_move_right"):#D
		#check to see if the player is in the air or crouched
		#play appropriate animation
		#check to see if the enemy is hit, where, and apply damage
		#reduce stamina
		print("body melee attack")

	if Input.is_action_pressed("p2_move_up"):#W
		#reduce stamina slightly
		#check weapon block speed, apply delay
		#play head block animation
		#if the enemy attacks and it would have hit the head, check block value to see if it gets through
		#reduce stamina slightly when hit and blocked
		print("head block")

	if Input.is_action_pressed("p2_move_down"):#S
		#reduce stamina slightly
		#check weapon block speed, apply delay
		#play body block animation
		#if the enemy attacks and it would have hit the torso, check block value to see if it gets through
		#reduce stamina slightly when hit and blocked
		print("body block")

	if Input.is_action_pressed("ui_select"):#spacebar
		#charge heavy attack value depending on how long spacebar is held
		#play heavy attack animation
		#change damage based on charge value
		#check to see if the enemy is hit, where, and apply damage
		#reduce stamina 50%
		#make player stuck until a timer goes off
		print("heavy melee attack")

	if Input.is_action_pressed("Fkey"):#F
		#play the lunge animation
		#slight delay
		#quickly move in the direction facing
		#attack with higher damage than normal
		#check to see if the enemy is hit, where, and apply damage
		#drastically reduce stamina
		#make player stuck until a timer goes off
		print("lunge attack")

	if (stamina < 100):
		stamina += staminaRegen
	if (stamina < 0):
		stamina = 0
	if (stamina > maxStamina):
		stamina = maxStamina
	
	totalHealth = calculateHealth()
	#apply movement and gravity
	motion.y += GRAVITY
	self.move_and_collide(motion)

	pass
