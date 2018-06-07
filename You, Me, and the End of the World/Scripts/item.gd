extends Node

var itemName = 'Unknown'
var worth = 0

func __init__(itemName, worth):
	self.itemName = itemName
	self.worth = worth

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
