extends KinematicBody2D

func _ready():
	pass

func handle_item_pickup(player):
	var parent = self.get_parent()
	self.queue_free()
	parent.queue_free()
	
