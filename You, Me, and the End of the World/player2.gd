extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 3 # Pixels/second
const invWaitTime = 1
var itemList = Dictionary()
var invCooldown = true
var invTimer = Timer.new()

func _ready():
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
		#print("following player 1")
		pass
	if Input.is_action_pressed("p2_inventory"):
		if !invCooldown:
			invCooldown = true
			_restart_invTimer()
			if len(itemList) == 0:
				print("P2\'s inventory is empty")
			else:
				var itemListKeys = itemList.keys()
				for i in range(0,itemListKeys.size()):
					if(itemList[itemListKeys[i]] == 1):
						print(itemList[itemListKeys[i]], ' ', itemListKeys[i])
					else:
						print(itemList[itemListKeys[i]], ' ', itemListKeys[i], 's')
	
	motion = motion.normalized() * MOTION_SPEED
	var collision_info = move_and_collide(motion)
	
	#collision handling
	if collision_info:
		var collision_object = collision_info.collider
		#Use handle_collide() on any object you wish to handle the collision with this KinematicBody2d
		if collision_object.has_method('handle_collide'):
			collision_object.handle_collide(self)

func addItem(item):
	if(itemList.has(item.itemName)):
		itemList[item.itemName] += 1
	else:
		itemList[item.itemName] = 1
	print('Added 1 ' , item.itemName , ' to p2\'s inventory')
	
