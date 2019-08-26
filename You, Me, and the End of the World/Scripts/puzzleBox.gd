extends KinematicBody2D

onready var isInArea
var isTouchingPlayer
var velocity = Vector2()

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
		collision.collider.move_and_slide(velocity * delta)
	pass
