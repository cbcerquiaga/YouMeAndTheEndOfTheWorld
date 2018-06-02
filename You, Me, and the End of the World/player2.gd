extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 3 # Pixels/second

func _physics_process(delta):
	var motion = Vector2()
	var isPlaying = get_node("/root/dungeon").get("isp2Playing")
	if (isPlaying):
		if Input.is_action_pressed("p2_move_up"):
			motion += Vector2(0, -1)
		if Input.is_action_pressed("p2_move_down"):
			motion += Vector2(0, 1)
		if Input.is_action_pressed("p2_move_left"):
			motion += Vector2(-1, 0)
		if Input.is_action_pressed("p2_move_right"):
			motion += Vector2(1, 0)
	else: #pathfinding algorithm
		print("following player 1")
	
	motion = motion.normalized() * MOTION_SPEED
	var collision_info = move_and_collide(motion)
	
	#collision handling
	if collision_info:
		var collision_object = collision_info.collider
		#Use handle_collide() on any object you wish to handle the collision with this KinematicBody2d
		if collision_object.has_method('handle_collide'):
			collision_object.handle_collide();
