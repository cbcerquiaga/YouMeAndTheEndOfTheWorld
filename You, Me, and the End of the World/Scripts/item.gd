extends StaticBody2D

#Initializing
var itemName = 'Unknown'
var itemType = "misc"
var worth = 0
var weight = 0
var packedScenePath = ""
var scriptPath = ""
var quantity = ""
var description = "an item that can be stored in the inventory and dropped and stuff"

onready var itemPopup = get_parent().get_parent().get_node("Item_popup")
onready var itemLabel = get_node("Label")
#itemName will be the identifying variable for the item
#worth TODO
#weight is the value that will contribute to the player's carry cap
#numberInStack is the number that is in this item, IE 43 dollars
#scenePath, path to the tscn file for this item, this will be assigned to the object if dropped from inventory
#scriptPath, path to this object's script, this will be assigned to the object if dropped from inventory
func init__(_itemName, _itemType, _worth, _weight, _quantity, _scenePath, _scriptPath):
	self.itemName = _itemName
	self.itemType = _itemType
	self.worth = _worth
	self.weight = _weight
	self.packedScenePath = _scenePath
	self.scriptPath = _scriptPath
	self.quantity = _quantity
	if(itemPopup != null):
		self.connect("mouse_entered", itemPopup, "_mouse_entered", [self])
		self.connect("mouse_exited", itemPopup, "_mouse_exited", [self])
	update_label()

func update_label():
	if(itemLabel != null):
		if(quantity > 1):
			itemLabel.text = str(quantity)
			pass
	#Handle Label here
	pass
	
#Fuctions
#This is the function called when the player picks up the item
#First we try to add the item to the player's inventory
#Then we hide the item from the scene, but it is still there and inactive
#TODO If we free the item this will not allow the player to drop it later, could be done better?
func handle_item_pickup(player):
	if(player.has_method('addItem')):
		player.addItem(self)
		deactivate()
		

func __eq__(other):
	if(self.itemName == other.itemName):
		if(self.worth == other.worth):
			if(self.weight == other.weight):
				if(self.packedScenePath == other.packedScenePath):
					if(self.scriptPath == other.scriptPath):
						return true
	return false

func getName():
	return itemName

func getQuantity():
	return quantity

#Sets this item so that it can be stored in inventory and accessed in the 2D world later
func deactivate():
	hide()
	set_collision_layer_bit(1, false)
	set_collision_mask_bit(1, false)

#Sets this item to be stored in the 2D world
func activate(location):
	set_collision_layer_bit(1, true)
	set_collision_mask_bit(1, true)
	self.position = location
	show()
	
#var itemName = 'Unknown'
#var worth = 0
#var weight = 0
#var packedScenePath = ""
#var scriptPath = ""
#var quantity = ""
func str():
	var output = str("itemName: ", itemName, "\n",
	"worth: ", worth, "\n",
	"weight: ", weight, "\n",
	"packedScenePath: ", packedScenePath, "\n",
	"scriptPath: ", scriptPath, "\n",
	"quantity: ", quantity, "\n")
	return output
	
	
	
	
	
	
	