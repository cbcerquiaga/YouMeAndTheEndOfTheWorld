extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 160 # Pixels/second


func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("p2_move_up"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("p2_move_down"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("p2_move_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("p2_move_right"):
		motion += Vector2(1, 0)
	
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)
