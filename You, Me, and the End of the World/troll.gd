extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const invWaitTime = 1
var playerProperty = preload('res://PlayerProperties.gd').new()
var invCooldown = true
var invTimer = Timer.new()

func _ready():
	playerProperty.__init__(1,1,1,1)
	invTimer.connect("timeout",self,"_on_invTimer_timeout")
	add_child(invTimer)
	invTimer.wait_time = invWaitTime
	invTimer.start()
	
func _restart_invTimer():
	if invTimer.wait_time <= 0:
		invTimer.wait_time = invWaitTime
		invTimer.start()

func _on_invTimer_timeout():
	invCooldown = false

func _physics_process(delta):
	var motion = Vector2()
	var isPlaying = get_node("/root/dungeon").get("isp1Playing")
	if (isPlaying):
		if Input.is_action_pressed("move_up"):
			motion += Vector2(0, -1)
		if Input.is_action_pressed("move_bottom"):
			motion += Vector2(0, 1)
		if Input.is_action_pressed("move_left"):
			motion += Vector2(-1, 0)
		if Input.is_action_pressed("move_right"):
			motion += Vector2(1, 0)
	else: #pathfinding algorithm
		#print("following player 2")
		pass
	if Input.is_action_pressed("p1_inventory"):
		if !invCooldown:
			invCooldown = true
			_restart_invTimer()
			playerProperty.str('p1')
	
	motion = motion.normalized() * playerProperty.getSpeed()
	move_and_slide(motion)
	
	#returns several collisions since the last move_and_slide call
	for i in range(get_slide_count()):
		var collision_object = get_slide_collision(i).collider
		if collision_object.has_method('handle_collide'):
			collision_object.handle_collide(self);
		
	

func addItem(item):
	playerProperty.addItem(item, 'p1')


