extends Node2D

var numAreas = 0
var currentIdentifier
var currentArea
var boxCount
onready var box = get_node("box")

# Called when the node enters the scene tree for the first time.
func _ready():
	#the box will always be a child, and there will only be one box- to make a multi-box puzzle, we need multiple instances of boxAreas
	numAreas = get_child_count() - 1
	pass

#all child areas must be named "PushTile" + number, with the number starting at 0 for this to work
func _process(delta):
	for i in range(0, numAreas):
		boxCount = 0
		currentIdentifier = "PushTile" + str(i)
		currentArea = get_node(currentIdentifier)
		if currentArea.overlaps_body(box):
			boxCount = boxCount + 1
	if boxCount > 0:
		box.isInArea = true
	else:
		box.isInArea = false
	pass
