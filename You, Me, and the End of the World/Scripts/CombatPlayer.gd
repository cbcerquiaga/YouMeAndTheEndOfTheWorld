extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var isCrouched = false
	var isInAir = false
	var isGrappling = false #if the player and enemy are grappling,
	#the player and enemy are stuck together with whoever has more
	#strength having greater control over movement. In this situation,
	# both can maneuver for a body slam, and the lunge, heavy, and
	# ranged attacks won't work anymore
	var stamina
	var staminaRegen
	var agility
	var strength
	var meleeDamageBonus #based on perks
	var rangedSpreadBonus #based on perks
	var headHealth = 100
	var torsoHealth = 100
	var armHealth = 100
	var legHealth = 100
	var totalHealth #heavily weights head and torso health
	var bleedRate
	var ammoLeft
	var rangedWeapon #check the player's inventory for an equipped
	#ranged weapon. This affects fire rate, spread, projectile speed,
	#how many shots can be fired, damage, and bonus affects
	var meleeWeapon #check the player's inventory for an equipped
	#melee weapon. This affects reach, damage, grappling, blocking,
	#speed, and bonus affects
	pass

func _physics_process(delta):
	var motion = Vector2()
	if Input.is_action_pressed("p1_move_up"):#up arrow
		#increase jump height depending on duration of jump hold and player's agility
		#play jump animation
		#stop jump if player releases button or max height reached
		#accelerate towards the ground
		#if isCrouched, increase groundward acceleration
		#stop upon reaching the ground
		print("jump")

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

	self.move_and_slide(motion * 200)

	pass
