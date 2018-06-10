extends KinematicBody2D

# Member variables
const invWaitTime = 1
var playerProperty = preload('res://Scripts/PlayerProperties.gd').new()
var invCooldown = true
var invTimer = Timer.new()
var overallHealth = 100 #TODO:add a function to get a player health value based on damage, food, cold, etc
var currentEXP = 99 #EXP is out of 100
var carryWeight = 0
var maxCarry = 200
signal move

#Called when the player is entered into the scene
func _ready():
	playerProperty.__init__(1,1,1,1)
	invTimer.connect("timeout",self,"_on_invTimer_timeout")
	add_child(invTimer)
	invTimer.wait_time = invWaitTime
	invTimer.start()

#Called to restart the invTimer, they will not set it if the timer is still active
func _restart_invTimer():
	if invTimer.wait_time <= 0:
		invTimer.wait_time = invWaitTime
		invTimer.start()

#Called whenever invTimer hits 0
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
			playerProperty.str('p2')
	if Input.is_action_pressed("p2_action1"):
		set_collision_mask_bit(1, true)
		var collisionEvent = move_and_collide(Vector2(0,0))
		if collisionEvent:
			if collisionEvent.collider.has_method("handle_door_unlock"):
				collisionEvent.collider.handle_door_unlock(self)
			if collisionEvent.collider.has_method("handle_item_pickup"):
				collisionEvent.collider.handle_item_pickup(self)
		set_collision_mask_bit(1, false)
	
	#playerProperty.getSpeed() calculates the default speed times any perks or trait bonuses
	motion = motion.normalized() * playerProperty.getSpeed()
	move_and_slide(motion)
	
	#If the player moved in this frame then emit the move signal
	if motion != Vector2(0,0):
		emit_signal("move")
	
	#Create a dictionary because there are no sets, and dictionaries can be used
	#for their unique key generation
	var collision_objects = Dictionary()
	#to make sure there is no leftovers from the last list of collision_objects
	collision_objects.clear()
	for i in range(get_slide_count()):
		#Set to 0 just as a placeholder, does not matter the value
		collision_objects[get_slide_collision(i).collider] = 0
	
	#parses through each unique object and tried to call it's handle_collide() method
	for i in range(len(collision_objects.keys())):
		if collision_objects.keys()[i].has_method('handle_collide'):
			collision_objects.keys()[i].handle_collide(self);

#adds an item to the player inventory, it makes a call to playerProperty's addItem method
func addItem(item):
	playerProperty.addItem(item, 'p2')
	


