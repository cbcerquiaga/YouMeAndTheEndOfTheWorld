extends KinematicBody2D

onready var isInArea
var isTouchingPlayer
var velocity = Vector2()

const SPEED = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	isInArea = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision and isInArea:
		print("move, sucka")
        # To make the other kinematicbody2d move as well
		var collision_point = collision.position
		#print("point: " + str(collision_point))
		if collision_point.x > position.x:
			velocity.x = -SPEED
		elif collision_point.x < position.x:
			velocity.x = SPEED
		if collision_point.y > position.y:
			velocity.y = -SPEED
		elif collision_point.y < position.y:
			velocity.y = SPEED
	else:
		if velocity.x > 10:
			velocity.x = velocity.x - 10
		elif velocity.x < -10:
			velocity.x = velocity.x + 10
		if velocity.y > 10:
			velocity.y = velocity.y - 10
		elif velocity.y < -10:
			velocity.y = velocity.y + 10
		if velocity.x > 0:
			velocity.x = velocity.x - 1
		elif velocity.x < 0:
			velocity.x = velocity.x + 1
		if velocity.y > 0:
			velocity.y = velocity.y - 1
		elif velocity.y < 0:
			velocity.y = velocity.y + 1
	pass
