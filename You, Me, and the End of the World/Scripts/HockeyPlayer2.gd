extends KinematicBody2D

const SPEED = 40000
const ROTATIONSPEED = 150
const ACCELERATION = 9000
var velocity = Vector2()
var currentSpeed = 0

func _ready():
	rotation = PI
	rotation_degrees = 0

func _process(delta):
	if Input.is_action_pressed("p2_move_left"):
		if currentSpeed > 0:
			currentSpeed -= 300
		rotation_degrees -= ROTATIONSPEED * delta
		velocity = Vector2(1, 0).rotated(rotation) * currentSpeed * delta
	if Input.is_action_pressed("p2_move_right"):
		if currentSpeed > 0:
			currentSpeed -= 300
		rotation_degrees += ROTATIONSPEED * delta
		velocity = Vector2(1, 0).rotated(rotation) * currentSpeed * delta
	if Input.is_action_pressed("p2_move_up"):
		if currentSpeed < SPEED:
			currentSpeed += ACCELERATION
		velocity = Vector2(1, 0).rotated(rotation) * currentSpeed * delta
	velocity = move_and_slide(velocity)