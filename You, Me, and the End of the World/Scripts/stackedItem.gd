extends 'res://Scripts/item.gd'
var numberInStack = 1;
var item = preload("res://Scripts/item.gd").new()

func _ready():
	pass

func __init__(item, numberInStack):
	self.item = item
	self.numberInStack = numberInStack
	if(itemPopup != null):
		print("Found item popup")
		self.connect("mouse_entered", itemPopup, "_mouse_entered", [item.__itemName])
		self.connect("mouse_exited", itemPopup, "_mouse_exited", [item.__itemName])

func handle_item_pickup(player):
	if(player.has_method('addItem')):
		player.addItem(item, numberInStack)
		self.set_collision_mask_bit(1, false)
		self.set_collision_layer_bit(1, false)
		self.hide()

func getItem():
	return item

func getStackNum():
	return numberInStack