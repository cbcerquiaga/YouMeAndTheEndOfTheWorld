extends Popup

var isPopupUp = false
var leftKey
var rightKey
var upKey
var downKey
var enterKey
var escKey
var closeKey
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
onready var optionPopup = get_node("Popup")

func _ready():
	alternateSegmentFrames()
	tabs = ["weapons","equippable","consumable","misc","car"]
	highlight = get_node("Player Segments/Highlight")
	carHighlight = get_node("Car Segments/Highlight")
	weaponButton.connect("pressed",self,"weaponButtonPressed")
	consumableButton.connect("pressed",self,"consumableButtonPressed")
	equippableButton.connect("pressed",self,"equippableButtonPressed")
	miscButton.connect("pressed",self,"miscButtonPressed")
	pass
	
#lets the inventroy be controlled by different keys
func setKeys(_leftKey, _rightKey, _upKey, _downKey, _enterKey, _escKey, _closeKey):
	leftKey = _leftKey
	rightKey = _rightKey
	upKey = _upKey
	downKey = _downKey
	enterKey = _enterKey
	escKey = _escKey
	closeKey = _closeKey
	
func alternateSegmentFrames():
	get_node("Player Segments/pSegment1").switchIcon()
	get_node("Player Segments/pSegment3").switchIcon()
	get_node("Player Segments/pSegment5").switchIcon()
	get_node("Player Segments/pSegment7").switchIcon()
	get_node("Car Segments/cSegment1").switchIcon()
	get_node("Car Segments/cSegment3").switchIcon()
	get_node("Car Segments/cSegment5").switchIcon()
	get_node("Car Segments/cSegment7").switchIcon()
	
	
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
	
func moveHighlight():
	if !inCarInventory:
		if currentItem == 0:
			pSegment0ButtonPressed()
		elif currentItem == 1:
			pSegment1ButtonPressed()
		elif currentItem == 2:
			pSegment2ButtonPressed()
		elif currentItem == 3:
			pSegment3ButtonPressed()
		elif currentItem == 4:
			pSegment4ButtonPressed()
		elif currentItem == 5:
			pSegment5ButtonPressed()
		elif currentItem == 6:
			pSegment6ButtonPressed()
		elif currentItem == 7:
			pSegment7ButtonPressed()
		elif currentItem == 8:
			pSegment8ButtonPressed()
	else: #if inCarInentory:
		if currentItem == 0:
			cSegment0ButtonPressed()
		elif currentItem == 1:
			cSegment1ButtonPressed()
		elif currentItem == 2:
			cSegment2ButtonPressed()
		elif currentItem == 3:
			cSegment3ButtonPressed()
		elif currentItem == 4:
			cSegment4ButtonPressed()
		elif currentItem == 5:
			cSegment5ButtonPressed()
		elif currentItem == 6:
			cSegment6ButtonPressed()
		elif currentItem == 7:
			cSegment7ButtonPressed()
		elif currentItem == 8:
			cSegment8ButtonPressed()

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
	
func pSegment0ButtonPressed():
	if !isSegmentEmpty(0):
		highlight.set_position(Vector2(0,0))
		currentItem = 0
		
func pSegment1ButtonPressed():
	if !isSegmentEmpty(1):
		highlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 1
		
func pSegment2ButtonPressed():
	if !isSegmentEmpty(2):
		highlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 2
		
func pSegment3ButtonPressed():
	if !isSegmentEmpty(3):
		highlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 3
		
func pSegment4ButtonPressed():
	if !isSegmentEmpty(4):
		highlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 4
		
func pSegment5ButtonPressed():
	if !isSegmentEmpty(5):
		highlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 5
		
func pSegment6ButtonPressed():
	if !isSegmentEmpty(6):
		highlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 6
		
func pSegment7ButtonPressed():
	if !isSegmentEmpty(7):
		highlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 7
		
func pSegment8ButtonPressed():
	if !isSegmentEmpty(8):
		highlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 8
		
func cSegment0ButtonPressed():
	if !isSegmentEmpty(0):
		carHighlight.set_position(Vector2(0,0))
		currentItem = 0
		
func cSegment1ButtonPressed():
	if !isSegmentEmpty(1):
		carHighlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 1
		
func cSegment2ButtonPressed():
	if !isSegmentEmpty(2):
		carHighlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 2
		
func cSegment3ButtonPressed():
	if !isSegmentEmpty(3):
		carHighlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 3
		
func cSegment4ButtonPressed():
	if !isSegmentEmpty(4):
		carHighlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 4
		
func cSegment5ButtonPressed():
	if !isSegmentEmpty(5):
		carHighlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 5
		
func cSegment6ButtonPressed():
	if !isSegmentEmpty(6):
		carHighlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 6
		
func cSegment7ButtonPressed():
	if !isSegmentEmpty(7):
		carHighlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 7
		
func cSegment8ButtonPressed():
	if !isSegmentEmpty(8):
		carHighlight.set_position(Vector2(0,0)) #TODO: figure out spacing
		currentItem = 8
	
func itemSelected():
	print("item at index " + str(currentItem) + " selected from Car inventory: " + str(inCarInventory))
	isPopupUp = true
	if inCarInventory:
		print("popup goes on the bottom")
		optionPopup.show()
		optionPopup.set_position(Vector2(385,425))
	else:
		print("popup goes on top")
		optionPopup.show()
		optionPopup.set_position(Vector2(385,135))
	if currentTab == "car":
		optionPopup.setText("equip to car", "detailed info", "move to other inventory", "drop", "dismantle for parts")
	else:
		optionPopup.setText("move to other inventory", "detailed info", "drop", "", "")
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
		
func isSegmentEmpty(segmentNum):
	if inCarInventory:
		if segmentNum == 0:
			if get_node("Car Segments/cSegment0").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 1:
			if get_node("Car Segments/cSegment1").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 2:
			if get_node("Car Segments/cSegment2").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 3:
			if get_node("Car Segments/cSegment3").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 4:
			if get_node("Car Segments/cSegment4").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 5:
			if get_node("Car Segments/cSegment5").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 6:
			if get_node("Car Segments/cSegment6").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 7:
			if get_node("Car Segments/cSegment7").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 8:
			if get_node("Car Segments/cSegment8").getText() == "":
				return true
			else:
				return false
	else: #in player inventory
		if segmentNum == 0:
			if get_node("Player Segments/pSegment0").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 1:
			if get_node("Player Segments/pSegment1").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 2:
			if get_node("Player Segments/pSegment2").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 3:
			if get_node("Player Segments/pSegment3").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 4:
			if get_node("Player Segments/pSegment4").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 5:
			if get_node("Player Segments/pSegment5").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 6:
			if get_node("Player Segments/pSegment6").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 7:
			if get_node("Player Segments/pSegment7").getText() == "":
				return true
			else:
				return false
		elif segmentNum == 8:
			if get_node("Player Segments/pSegment8").getText() == "":
				return true
			else:
				return false
	
#sets the text above the items in both areas
func setBasicText():
	get_node("Top Basic Info").currentTab = currentTab
	get_node("Bottom Basic Info").currentTab = currentTab

func _process(delta):
	currentTab = tabs[tabIndex]
	if Input.is_action_just_pressed(str(leftKey)):
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
	elif Input.is_action_just_pressed(str(rightKey)):
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
	if Input.is_action_just_pressed(str(upKey)):
		if currentItem > 0 and !isSegmentEmpty(currentItem - 1): #not already the top and the next segment isn't empty
			#if currentItem == topItem: #need to scroll up
			#	topItem = topItem - 1
			#	scrollUp()
			currentItem = currentItem - 1
			moveHighlight()
	elif Input.is_action_just_pressed(str(downKey)):
		if currentItem < 13 and !isSegmentEmpty(currentItem + 1): #not already the bottom and the next segment isn't empty
			#if currentItem == (topItem - 13): #need to scroll down
			#	topItem = topItem + 1
			#	scrollDown()
			currentItem = currentItem + 1
			moveHighlight()
	if inCarInventory:
		get_node("Player Segments/Highlight/Sprite").hide()
		get_node("Car Segments/Highlight/Sprite").show()
		
	else:
		get_node("Car Segments/Highlight/Sprite").hide()
		get_node("Player Segments/Highlight/Sprite").show()
	pass
