extends 'res://Scripts/hockey_player.gd'

const SPEED = 50000
const ROTATIONSPEED = 200
const ACCELERATION = 6000
var velocity = Vector2()
var currentSpeed = 0
var rotationMod = 1

func _ready():
	rotation = PI
	rotation_degrees = 0

func _process(delta):
	if currentSpeed > 100: #adds friction
		currentSpeed -= 100
	elif currentSpeed < -100:#when going backwards too
		currentSpeed += 100
	if Input.is_action_pressed("p2_move_left"):
		if currentSpeed > 0:
			currentSpeed -= 200
			#adjust turn tightness based on speed
			if currentSpeed <= SPEED/4:
				rotationMod = 2
			elif currentSpeed <= SPEED/2:
				rotationMod = 1.5
			else:
				rotationMod = 1
		elif currentSpeed < 0:
			currentSpeed += 100
		rotation_degrees -= ROTATIONSPEED * delta * rotationMod
	if Input.is_action_pressed("p2_move_right"):
		if currentSpeed > 0:
			currentSpeed -= 200
			#adjust turn tightness based on speed
			if currentSpeed <= SPEED/4:
				rotationMod = 2
			elif currentSpeed <= SPEED/2:
				rotationMod = 1.5
			else:
				rotationMod = 1
		elif currentSpeed <0:
			currentSpeed += 100
		rotation_degrees += ROTATIONSPEED * delta *rotationMod
	if Input.is_action_pressed("p2_move_up"): #acceleration
		if currentSpeed < SPEED:
			currentSpeed += ACCELERATION
	if Input.is_action_pressed("p2_move_down"):#brakes
		if currentSpeed > -SPEED/2:
			currentSpeed-= ACCELERATION/2
	velocity = Vector2(1, 0).rotated(rotation) * currentSpeed * delta	
	velocity = move_and_slide(velocity)