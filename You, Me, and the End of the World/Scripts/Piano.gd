extends 'item.gd'

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var pickedUp = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
#	self.mode = MODE_STATIC
	__init__('GrandPiano', 100, 3, "res://tscn files/Piano.tscn", "res://Scripts/Piano.gd")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_player1_pickupItem(player):
	set_collision_layer_bit(0,true)
#	print("picked up signal")
	var space = self.get_world_2d().direct_space_state
	var collision = space.intersect_ray(self.global_position, player.global_position)
	if collision.collider == player and pickedUp == false and self.is_colliding:
		player.addItem(self)
		self.hide()
		pickedUp = true
	set_collision_layer_bit(0,false)
#		if i.collider == player:
#			player.addItem(self)
#	if self.get_collider() == player:
#		print("OH GOD YOU ARE PICKING ME UP, THERE IS NO GOD")
#		if player.has_method("addItem"):
#			player.addItem(self)
#			self.hide()
#			set_collision_mask_bit(0, false)
#			set_collision_layer_bit(0, false)