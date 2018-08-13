extends StaticBody2D

#Initializing
var __itemName = 'Unknown'
var __worth = 0
var __weight = 0
var __packedScenePath = ""
var __scriptPath = ""

onready var itemPopup = get_parent().get_parent().get_node("Item_popup")
#itemName will be the identifying variable for the item
#worth TODO
#weight is the value that will contribute to the player's carry cap
#numberInStack is the number that is in this item, IE 43 dollars
#scenePath, path to the tscn file for this item, this will be assigned to the object if dropped from inventory
#scriptPath, path to this object's script, this will be assigned to the object if dropped from inventory
func __init__(itemName, worth, weight, scenePath, scriptPath):
	self.__itemName = itemName
	self.__worth = worth
	self.__weight = weight
	self.__packedScenePath = scenePath
	self.__scriptPath = scriptPath
	if(itemPopup != null):
		print("Found item popup")
		self.connect("mouse_entered", itemPopup, "_mouse_entered", [itemName])
		print("Connected mouse entered with ", itemName)
		self.connect("mouse_exited", itemPopup, "_mouse_exited", [itemName])
		print("Connected mouse exited with ", itemName)

#Fuctions
#This is the function called when the player picks up the item
#First we try to add the item to the player's inventory
#Then we hide the item from the scene, but it is still there and inactive
#TODO If we free the item this will not allow the player to drop it later, could be done better?
func handle_item_pickup(player):
	if(player.has_method('addItem')):
		player.addItem(self, 1)
		self.hide()
