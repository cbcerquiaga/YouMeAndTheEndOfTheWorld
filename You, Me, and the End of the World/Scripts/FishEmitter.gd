extends Node2D

onready var availableFish = ["bass", "trout", "eel", "mutant", "gold", "minnow"]
onready var fish = load("res://Scripts/BasicFish.gd")
var maxDepth = 100 #default maximum depth unless a new one is given

func _ready():
	#figure out how many fish to instance
	var numFish = int(round(rand_range(0, 30)))
	for i in range (0, numFish):
		var fishType = chooseFishType()
		spawnFish(fishType) #figure out what kind of fish to spawn
	pass

func setMaxDepth(number):
	maxDepth = number

func chooseFishType():
	var index = rand_range(0, availableFish.size())
	return availableFish[index]
	pass
	
func spawnFish(type):
	var depth = rand_range(0, maxDepth)
	var width = rand_range(0, 50)#width of the scene area
	var thisFish = fish.instance()
	thisFish.set_position(Vector2(width, depth))
	self.get_parent().add_child(thisFish)
	#var sprite = get_sprite(type) #TODO: get assets and make an actual call to change the sprite
	pass

func changeAvailableFish(newArray):
	availableFish = newArray