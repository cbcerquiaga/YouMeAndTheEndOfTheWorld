extends Popup

var highlight
var carHighlight
var currentItem = 0
var tabs
var currentTab
var inCarInventory = false
var carParts
var weaponItems
var equippableItems
var consumableItems
var miscItems
var car_carParts
var car_weaponItems
var car_equippableItems
var car_consumableItems
var car_miscItems
onready var tabIndex = 0
onready var weaponButton = get_node("Tabs/Weapons")
onready var consumableButton = get_node("Tabs/Consumable")
onready var equippableButton = get_node("Tabs/Equippable")
onready var miscButton = get_node("Tabs/Misc")
onready var carButton = get_node("Tabs/Customize car")

func _ready():
	tabs = ["weapons","equippable","consumable","misc","car"]
	highlight = get_node("Player Segments/Highlight")
	carHighlight = get_node("Car Segments/Highlight")
	weaponButton.connect("pressed",self,"weaponButtonPressed")
	consumableButton.connect("pressed",self,"consumableButtonPressed")
	equippableButton.connect("pressed",self,"equippableButtonPressed")
	miscButton.connect("pressed",self,"miscButtonPressed")
	pass
	
#split the player's inventory into several arrays based on item type
func loadPlayerInventory(list):
	carParts = [] #TODO: get a list of potential car augmentations
	weaponItems = []
	equippableItems = []
	consumableItems = []
	miscItems = []
	for i in list:
		if i.itemType == "car":
			carParts.append(i)
		elif i.itemType == "weapon":
			weaponItems.append(i)
		elif i.itemType == "equippable":
			equippableItems.append(i)
		elif i.itemType == "consumable":
			consumableItems.append(i)
		else: # i.itemType == "misc":
			miscItems.append(i)
			
func loadCarInventory(list):
	car_carParts = []
	car_weaponItems = []
	car_equippableItems = []
	car_consumableItems = []
	car_miscItems = []
	for i in list:
		if i.itemType == "car":
			car_carParts.append(i)
		elif i.itemType == "weapon":
			car_weaponItems.append(i)
		elif i.itemType == "equippable":
			car_equippableItems.append(i)
		elif i.itemType == "consumable":
			car_consumableItems.append(i)
		else: # i.itemType == "misc":
			car_miscItems.append(i)
	
func weaponButtonPressed():
	highlight.set_position(Vector2(0,0))
	tabIndex = 0
	currentItem = 0
	moveHighlight()
	
func equippableButtonPressed():
	highlight.set_position(Vector2(60,0))
	tabIndex = 1
	currentItem = 0
	moveHighlight()
	
func consumableButtonPressed():
	highlight.set_position(Vector2(120,0))
	tabIndex = 2
	currentItem = 0
	moveHighlight()
	
func miscButtonPressed():
	highlight.set_position(Vector2(180,0))
	tabIndex = 2
	currentItem = 0
	moveHighlight()

func carButtonPressed():
	highlight.set_position(Vector2(240,0))
	tabIndex = 2
	currentItem = 0
	moveHighlight()
	
func itemSelected():
	print("item at index " + str(currentItem) + " selected")
	#TODO: if the item is chosen from the player's inventory, move it to the car's inventory
	#TODO: if the item is chosen from the car's inventory, move it to the player's inventory
	
#checks what tab the screen is on, and sets the inventory screen
#accordingly
func setInventorySegments():
	resetSegmentText()
	#currentItem = 0
	#moveHighlight()
	if currentTab == "car":
		setSegments(carParts)
	elif currentTab == "misc":
		setSegments(miscItems)
	elif currentTab == "consumable":
		setSegments(consumableItems)
	elif currentTab == "equippable":
		setSegments(equippableItems)
	else: #currentTab == "weapons":
		setSegments(weaponItems)
	
#sets the text above the items in both areas
func setBasicText():
	get_node("Top Basic Info").currentTab = currentTab
	get_node("Bottom Basic Info").currentTab = currentTab

func _process(delta):
	currentTab = tabs[tabIndex]
	if Input.is_action_just_pressed("p1_move_left"):
		if currentTab == "weapons":
			carButtonPressed()
		elif currentTab == "car":
			miscButtonPressed()
		elif currentTab == "misc":
			consumableButtonPressed()
		elif currentTab == "consumable":
			equippableButtonPressed()
		else: #if currentTab == "equippable":
			weaponButtonPressed()
	elif Input.is_action_just_pressed("p1_move_right"):
		if currentTab == "weapons":
			equippableButtonPressed()
		elif currentTab == "equippable":
			consumableButtonPressed()
		elif currentTab == "consumable":
			miscButtonPressed()
		elif currentTab == "misc":
			carButtonPressed()
		else: #if currentTab == "car":
			weaponsButtonPressed()
	if inCarInventory:
		get_node("Player Segments/Highlight/Sprite").hide()
		get_node("Car Segments/Highlight/Sprite").show()
	else:
		get_node("Car Segments/Highlight/Sprite").hide()
		get_node("Player Segments/Highlight/Sprite").show()
	pass
