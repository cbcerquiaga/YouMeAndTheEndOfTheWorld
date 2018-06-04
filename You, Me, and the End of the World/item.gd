extends Node

func __init__(name, value):
	self.name = name
	self.value = value

func _getAttr(property):
	return self.property

func _setAttr(property, value):
	self.property = value

func handle_collide(player):
	if(player.has_method('addItem')):
		player.addItem(self)
		self.queue_free()
#func _ready():
#	# Called every time the node is added to the scene.
#	# Initialization here
#
#	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
