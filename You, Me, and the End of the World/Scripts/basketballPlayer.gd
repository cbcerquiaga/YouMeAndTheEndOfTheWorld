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

onready var catchArea = get_node("catchArea")
onready var holdArea = get_node("holdArea")

var isMouseNull = false

var velocity = Vector2()
var on_air_time = 100
var jumping = false

var prev_jump_pressed = false

onready var frozen = false

#combat-affecting variables
var isFacingRight = true

#player status variables
var stamina = 100 #the player's current stamina level
var maxStamina = 100 #the maximum stamina the player can have with their current fitness
var staminaRegen = .15 #how quickly the player's stamina regenerates
var agility
var jump
var spread = 15
var lastFrameEndSpeed = Vector2(0,0)


func _ready():
	#ready stuff
	pass

func _physics_process(delta):
	if !frozen:
	
		# Create forces
		var force = Vector2(0, GRAVITY)

		var walk_left = Input.is_action_pressed("p1_move_left")
		var walk_right = Input.is_action_pressed("p1_move_right")
		var block = Input.is_action_just_pressed("p1_action1")
		var steal = Input.is_action_just_pressed("p1_action2")
		var jump = Input.is_action_pressed("p1_move_up")
		var crouch = Input.is_action_pressed("p1_move_down")
		

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


func _on_Border_mouse_entered():
	isMouseNull = false
#	print("Mouse is not null")


func _on_Border_mouse_exited():
	isMouseNull = true
#	print("Mouse is null")

	
func updateFacingRight(boolean):
	isFacingRight = boolean
	if isFacingRight:
		get_node("Sprite").set_flip_h(false)
	else:
		get_node("Sprite").set_flip_h(true)
		
func freeze():
	frozen = true
	position.x = -6000
	
func unfreeze():
	frozen = false
	position.x = 100