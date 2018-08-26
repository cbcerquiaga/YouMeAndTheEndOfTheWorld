extends KinematicBody2D

# Member variables
const invWaitTime = 1
var playerProperty = preload('res://Scripts/PlayerProperties.gd').new()
var invCooldown = true
var invTimer = Timer.new()
var currentEXP = 99 #EXP is out of 100
var carryWeight = 0
var maxCarry = 200
onready var otherPlayer = get_node("../player2")
signal move
var isFrozen = false
onready var camera = get_node("../playerTracking/Camera")

#Called when the player is entered into the scene
func _ready():
	playerProperty.__init__(1,1,1,1)
	invTimer.connect("timeout", self, "_on_invTimer_timeout")
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
	#to set icon frame, use this line:
	#get_node("/root/dungeon/HUD/P1A1 Icon")._setFrame(1)
#	var player1InCamera = camera.get_viewport_rect().encloses(self.get_viewport_rect())
	var motion = Vector2()
	var isPlaying = get_node("/root/Root").get("isp1Playing")
	if (isPlaying and !isFrozen):
		if Input.is_action_pressed("p1_move_up"):
			motion += Vector2(0, -1)
		if Input.is_action_pressed("p1_move_down"):
			motion += Vector2(0, 1)
		if Input.is_action_pressed("p1_move_left"):
			motion += Vector2(-1, 0)
		if Input.is_action_pressed("p1_move_right"):
			motion += Vector2(1, 0)
	elif(!isPlaying): #pathfinding algorithm
		#print("following player 2")
		var distance = (otherPlayer.position - self.position)
		var farEnough = (abs(distance.x) > 100 or abs(distance.y) > 100)
		if farEnough:
			emit_signal("move")
			if get_slide_count() > 0:
				var right = Vector2(-distance.y, distance.x)
				move_and_slide(right)
			else:
				move_and_slide(distance)

	#This method ray-casts to detect any collisions with the player
	#https://godot.readthedocs.io/en/3.0/tutorials/physics/ray-casting.html
	if Input.is_action_pressed("p1_action1"):
		var space = self.get_world_2d().direct_space_state
		var collision = space.intersect_ray(self.global_position, Vector2(0,0), [self], 2)
		if collision.empty() == false:
			if collision.collider.has_method('handle_item_pickup'):
				collision.collider.handle_item_pickup(self)

	#This method will drop items from the inventory.
	#This method can simply be modified to take into
	#account the selectedItem, but for now I just used 0
	if Input.is_action_pressed("p1_action2"):
		if !playerProperty.isEmpty():
			#TODO: changed the selected item to an appropriate value
			playerProperty.selectItemByIndex(0)
			var item = playerProperty.getSelectedItem()
			playerProperty.removeItem(item, "p1")
			item.activate(self.position)
			item.update_label()
	
	#playerProperty.getSpeed() calculates the default speed times any perks or trait bonuses
	motion = motion.normalized() * playerProperty.getSpeed()

	#If the player moved in this frame then emit the move signal
	if motion != Vector2(0,0):
		move_and_slide(motion)
		emit_signal("move")
	
	#Create a dictionary because there are no sets, and dictionaries can be used
	#for their unique key generation
	var collision_objects = Dictionary()
	#to make sure there is no leftovers from the last list of collision_objects
	collision_objects.clear()
	for i in range(get_slide_count()-1):
		#Set to 0 just as a placeholder, does not matter the value
		collision_objects[get_slide_collision(i).collider] = 0

	#parses through each unique object and tried to call it's handle_collide() method
	for i in range(len(collision_objects.keys())-1):
		if collision_objects.keys()[i].has_method('handle_collide'):
			collision_objects.keys()[i].handle_collide(self)


#adds an item to the player inventory, it makes a call to playerProperty's addItem method
func addItem(item):
	playerProperty.addItem(item, 'p1')
	
func getInventory():
	return playerProperty.Inventory
	
func getHealth():
	playerProperty.calculateHealth()
	