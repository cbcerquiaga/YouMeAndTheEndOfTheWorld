extends StaticBody2D

#Initializing
var itemName = 'Unknown'
var worth = 0
var weight = 0
var packedScenePath = ""
var scriptPath = ""
var quantity = ""

onready var itemPopup = get_parent().get_parent().get_node("Item_popup")
onready var itemLabel = get_node("Label")
#itemName will be the identifying variable for the item
#worth TODO
#weight is the value that will contribute to the player's carry cap
#numberInStack is the number that is in this item, IE 43 dollars
#scenePath, path to the tscn file for this item, this will be assigned to the object if dropped from inventory
#scriptPath, path to this object's script, this will be assigned to the object if dropped from inventory
func init__(_itemName, _worth, _weight, _quantity, _scenePath, _scriptPath):
	self.itemName = _itemName
	self.worth = _worth
	self.weight = _weight
	self.packedScenePath = _scenePath
	self.scriptPath = _scriptPath
	self.quantity = _quantity
	if(itemPopup != null):
		self.connect("mouse_entered", itemPopup, "_mouse_entered", [itemName])
		self.connect("mouse_exited", itemPopup, "_mouse_exited", [itemName])
	if(itemLabel != null):
		if(quantity > 1):
			itemLabel.text = str(quantity)
			pass

func ready():
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