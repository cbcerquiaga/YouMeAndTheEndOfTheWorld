extends Node

var itemName = 'Unknown'
var worth = 0
var packedScenePath = ""
var scriptPath = ""

func __init__(itemName, worth, scenePath, scriptPath):
	self.itemName = itemName
	self.worth = worth
	self.packedScenePath = scenePath
	self.scriptPath = scriptPath

func _getAttr(property):
	return self.property

func getScriptPath():
	return self.scriptPath

func getScenePath():
	return self.packedScenePath

func _setAttr(property, value):
	self.property = value

func handle_item_pickup(player):
	if(player.has_method('addItem')):
		player.addItem(self)
		self.set_collision_mask_bit(1, false)
		self.set_collision_layer_bit(1, false)
		self.hide()
		



#func _ready():
#	# Called every time the node is added to the scene.
#	# Initialization here
#
#	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
