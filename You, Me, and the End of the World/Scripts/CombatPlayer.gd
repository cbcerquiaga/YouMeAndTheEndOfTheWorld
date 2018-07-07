extends KinematicBody2D

# Member variables
const GRAVITY = 500.0 # pixels/second/second
const CROUCH_SPEED = Vector2(0,2.5) #TODO

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 600
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 400
const JUMP_MAX_AIRBORNE_TIME = .4

const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

var velocity = Vector2()
var on_air_time = 100
var jumping = false

var prev_jump_pressed = false

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
var ammoLeft = 6
var ammoVal = str(ammoLeft)

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
var canJump = false


func _ready():
	#ready stuff
	pass

func calculateHealth():
	if headHealth == 0: #if the head is gone, the player is dead
		return 0
	elif torsoHealth == 0: #if the torso is gone, the player is dead
		return 0
	else: #weight head and torso health more than limb health
		var tempHealth = (headHealth + torsoHealth)*3 + (armHealth + legHealth)*2
		tempHealth = tempHealth/10
		if tempHealth < 100:
			tempHealth = tempHealth - 5
		if tempHealth < 75:
			tempHealth = tempHealth - 5
		if tempHealth < 50:
			tempHealth = tempHealth - 5
		if tempHealth < 25:
			tempHealth = tempHealth - 5
		return tempHealth
	pass

func _physics_process(delta):
	# Create forces
	var force = Vector2(0, GRAVITY)

	var walk_left = Input.is_action_pressed("p1_move_left")
	var walk_right = Input.is_action_pressed("p1_move_right")
	var jump = Input.is_action_pressed("p1_move_up")

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

	# Integrate forces to velocity
	velocity += force * delta
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))

	if is_on_floor():
		on_air_time = 0

	if jumping and velocity.y > 0:
		# If falling, no longer jumping
		jumping = false

	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED
		jumping = true

	on_air_time += delta
	prev_jump_pressed = jump
