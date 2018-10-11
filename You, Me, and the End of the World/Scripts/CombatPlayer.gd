extends KinematicBody2D

# Member variables
const GRAVITY = 500.0 # pixels/second/second
const CROUCH_GRAVITY = 120.0 #pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 900
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 400
const JUMP_MAX_AIRBORNE_TIME = .4

const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

var isMouseNull = false

var velocity = Vector2()
var on_air_time = 100
var jumping = false

var prev_jump_pressed = false

#combat-affecting variables
var isCrouched = false
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
var ammoLeft = 6
var ammoVal = str(ammoLeft)

#player status variables
var headDamageMultiplier = 2
var totalHealth = 100
var bleedRate
var stamina = 100 #the player's current stamina level
var maxStamina = 100 #the maximum stamina the player can have with their current fitness
var staminaRegen = .15 #how quickly the player's stamina regenerates
var agility
var strength
var maxHealth = 100
var spread = 15
var lastFrameEndSpeed = Vector2(0,0)

onready var bullet = load("res://tscn files/Bullet.tscn")

func _ready():
	#ready stuff
	pass

func _physics_process(delta):
	# Create forces
	var force = Vector2(0, GRAVITY)

	var walk_left = Input.is_action_pressed("p1_move_left")
	var walk_right = Input.is_action_pressed("p1_move_right")
	var dash_left = Input.is_action_just_pressed("p1_action1")
	var dash_right = Input.is_action_just_pressed("p1_action2")
	var jump = Input.is_action_pressed("p1_move_up")
	var crouch = Input.is_action_pressed("p1_move_down")
	var head_attack = Input.is_action_just_pressed("p2_action2")
	var body_attack = Input.is_action_just_pressed("p2_move_right")
	var heavy_attack = Input.is_action_pressed("Fkey")
	var head_block = Input.is_action_pressed("p2_move_up")
	var body_block = Input.is_action_pressed("p2_move_down")
	var grab = Input.is_action_just_pressed("ui_select")
	var shoot = Input.is_action_just_pressed("click")
	var taunt = Input.is_action_pressed("p2_move_left")
	var doneTaunting = Input.is_action_just_released("p2_move_left")

	var stop = true

	if walk_left:
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			stop = false
	elif walk_right:
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE
			stop = false

	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)

		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0

		velocity.x = vlen * vsign

	if head_attack:
		if stamina > 10: #enough for a head attack
			stamina -= 10
			#TODO: raycast to see what enemy body part is damaged
			#TODO: head attack animation

	if body_attack:
		if stamina > 10: #enough for a body attack
			stamina -= 10
			#TODO: raycast to see what enemy body part is damaged
			#TODO: body attack animation

	if head_block:
		stamina -= staminaRegen #stamina stops regenerating
		#TODO: move to block
		#TODO: reduce damage taken, apply it to blocking body part

	if body_block:
		stamina -= staminaRegen #stamina stops regenerating
		#TODO: move to block
		#TODO: reduce damage taken, apply it to blocking body part

	if grab:
		if stamina > 20: #enough stamina for a grab
			stamina -= 20
			#TODO: check to see if enemy is within range
			#TODO: pull enemy off balance
			#TODO: immobilize enemy more depending on the player's strength

	if heavy_attack:
		if stamina > 30:
			stamina -=30
			#TODO: check to see how long the button is held
			#TODO: play charge-up animation
			#TODO: check to see if enemy is in range
			#TODO: damage more based on how long the button is charged

	if shoot and !isMouseNull:
		if ammoLeft > 0: #there is ammo to shoot
			ammoLeft -= 1
			ammoVal = str(ammoLeft)
			#check coordinates, spawn a bullet
			var playerPosition = self.get_global_position()
			create_bullet(playerPosition)
			#TODO: apply spread based on weapon & skills
			#TODO: check where the enemy is hit and apply damage
			
	if dash_left:
		if stamina >= 35:
			force.x -= 60*WALK_FORCE
			stamina-=35
		
	if dash_right:
		if stamina >= 35:
			force.x += 60*WALK_FORCE
			stamina-=35

	if taunt:
		#make taunt gesture
		print("U wot m8?")
		#apply taunt effect to enemy
		#emit_signal(taunt)

	if doneTaunting:
		#return to regular animation frames
		print("Ur mum")

	# Integrate forces to velocity
	velocity += force * delta
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
	lastFrameEndSpeed = velocity

	if is_on_floor():
		on_air_time = 0
		if crouch:
			print("DUCK!")
			stamina -= staminaRegen/2 #stamina regenerates at half speed
			#TODO: play crouch animation
			#TODO: reduce hitbox size
	else:
		if crouch:
			print("cannonball!")
			velocity.y += CROUCH_GRAVITY

	if jumping and velocity.y > 0:
		# If falling, no longer jumping
		jumping = false

	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping and stamina > 20:
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED
		jumping = true
		stamina -= 20

	on_air_time += delta
	prev_jump_pressed = jump
	if stamina < maxStamina:
		stamina += staminaRegen
	pass

func create_bullet(position):
	var tempBullet = bullet.instance()
	tempBullet.set_position(self.position)
	var truePosition = get_local_mouse_position()
	truePosition.x += 15
	truePosition.y += 15
	#add spread based on bullet type
	var randSpread = int(rand_range(-spread,spread))
	truePosition.x += randSpread
	randSpread = int(rand_range(-spread,spread))
	truePosition.y += randSpread
	tempBullet.motion = truePosition.normalized()
	self.get_parent().add_child(tempBullet)


func _on_Border_mouse_entered():
	isMouseNull = false
#	print("Mouse is not null")


func _on_Border_mouse_exited():
	isMouseNull = true
#	print("Mouse is null")


func _on_Bullet_hit(bodyPart, damage, critChance):
	print("Hit! " + str(totalHealth))
	var randNum = rand_range(0,1)
	if bodyPart == "torso":
		if randNum > critChance: #not a critical hit
			totalHealth = totalHealth - damage
		else: #50% bonus damage
			print("CRITICAL STRIKE")
			totalHealth = totalHealth - (damage * 3/2)
	elif bodyPart == "head":
		if randNum > critChance: #not a critical hit
			totalHealth = (totalHealth - (damage*headDamageMultiplier))
		else:
			print("CRITICAL STRIKE")
			totalHealth = totalHealth - ((damage*headDamageMultiplier) * 3/2)
	print(str(totalHealth))
	pass
