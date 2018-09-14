extends Popup

var isPopupUp
var leftKey
var rightKey
var upKey
var downKey
var enterKey
var escKey
var justOpened
var L
var C
var R
var highlight
var itemHighlight
var currentFrame
var currentItem
var topItem
var quests
var weaponItems
var equippableItems
var consumableItems
var miscItems
var discoveredPlaces
var currentTab #stores text for current tab to make it easier to code other nodes
onready var tabIndex = 0
onready var tabs = ["quests","weapons","equippable","consumable","misc","map"]
onready var leftButton = get_node("Status Box/Left Button")
onready var rightButton = get_node("Status Box/Right Button")
onready var questButton = get_node("Tabs/questButton")
onready var weaponButton = get_node("Tabs/weaponButton")
onready var consumableButton = get_node("Tabs/consumableButton")
onready var equippableButton = get_node("Tabs/equippableButton")
onready var miscButton = get_node("Tabs/miscButton")
onready var mapButton = get_node("Tabs/mapButton")
onready var segment0 = get_node("Inventory Main/Segment0")
onready var segment1 = get_node("Inventory Main/Segment1")
onready var segment2 = get_node("Inventory Main/Segment2")
onready var segment3 = get_node("Inventory Main/Segment3")
onready var segment4 = get_node("Inventory Main/Segment4")
onready var segment5 = get_node("Inventory Main/Segment5")
onready var segment6 = get_node("Inventory Main/Segment6")
onready var segment7 = get_node("Inventory Main/Segment7")
onready var segment8 = get_node("Inventory Main/Segment8")
onready var segment9 = get_node("Inventory Main/Segment9")
onready var segment10 = get_node("Inventory Main/Segment10")
onready var segment11 = get_node("Inventory Main/Segment11")
onready var segment12 = get_node("Inventory Main/Segment12")
onready var segment13 = get_node("Inventory Main/Segment13")
onready var button0 = get_node("Inventory Main/Segment0/Button0")
onready var button1 = get_node("Inventory Main/Segment1/Button1")
onready var button2 = get_node("Inventory Main/Segment2/Button2")
onready var button3 = get_node("Inventory Main/Segment3/Button3")
onready var button4 = get_node("Inventory Main/Segment4/Button4")
onready var button5 = get_node("Inventory Main/Segment5/Button5")
onready var button6 = get_node("Inventory Main/Segment6/Button6")
onready var button7 = get_node("Inventory Main/Segment7/Button7")
onready var button8 = get_node("Inventory Main/Segment8/Button8")
onready var button9 = get_node("Inventory Main/Segment9/Button9")
onready var button10 = get_node("Inventory Main/Segment10/Button10")
onready var button11 = get_node("Inventory Main/Segment11/Button11")
onready var button12 = get_node("Inventory Main/Segment12/Button12")
onready var button13 = get_node("Inventory Main/Segment13/Button13")
onready var optionPopup = get_node("Inventory Main/ItemHighlight/OptionPopup")

func _ready():
	#self.queue_free()
	isPopupUp = false
	alternateSegmentFrames()
	quests = []
	weaponItems = []
	equippableItems = []
	consumableItems = []
	miscItems = []
	discoveredPlaces = []
	justOpened = true
	currentFrame = 0
	currentItem = 0
	topItem = 0
	currentTab = tabs[tabIndex]
	L = get_node("Status Box/Left Icon")
	C = get_node("Status Box/Center Icon")
	R = get_node("Status Box/Right Icon")
	highlight = get_node("Tabs/Highlight")
	itemHighlight = get_node("Inventory Main/ItemHighlight")
#	print("Highlight position: " + str(highlight.get_position()))
	leftButton.connect("pressed",self,"leftButtonPressed")
	rightButton.connect("pressed",self,"rightButtonPressed")
	questButton.connect("pressed",self,"questButtonPressed")
	weaponButton.connect("pressed",self,"weaponButtonPressed")
	consumableButton.connect("pressed",self,"consumableButtonPressed")
	equippableButton.connect("pressed",self,"equippableButtonPressed")
	miscButton.connect("pressed",self,"miscButtonPressed")
	mapButton.connect("pressed",self,"mapButtonPressed")
	button0.connect("pressed",self,"segment0ButtonPressed")
	button1.connect("pressed",self,"segment1ButtonPressed")
	button2.connect("pressed",self,"segment2ButtonPressed")
	button3.connect("pressed",self,"segment3ButtonPressed")
	button4.connect("pressed",self,"segment4ButtonPressed")
	button5.connect("pressed",self,"segment5ButtonPressed")
	button6.connect("pressed",self,"segment6ButtonPressed")
	button7.connect("pressed",self,"segment7ButtonPressed")
	button8.connect("pressed",self,"segment8ButtonPressed")
	button9.connect("pressed",self,"segment9ButtonPressed")
	button10.connect("pressed",self,"segment10ButtonPressed")
	button11.connect("pressed",self,"segment11ButtonPressed")
	button12.connect("pressed",self,"segment12ButtonPressed")
	button13.connect("pressed",self,"segment13ButtonPressed")
	pass
	
#lets the inventroy be controlled by different keys
func setKeys(_leftKey, _rightKey, _upKey, _downKey, _enterKey, _escKey):
	leftKey = _leftKey
	rightKey = _rightKey
	upKey = _upKey
	downKey = _downKey
	enterKey = _enterKey
	escKey = _escKey

#initializes the segment frames so that they alternate in color
func alternateSegmentFrames():
	segment1.switchIcon()
	segment3.switchIcon()
	segment5.switchIcon()
	segment7.switchIcon()
	segment9.switchIcon()
	segment11.switchIcon()
	segment13.switchIcon()
	
func switchAllSegmentFrames():
	segment0.switchIcon()
	segment1.switchIcon()
	segment2.switchIcon()
	segment3.switchIcon()
	segment4.switchIcon()
	segment5.switchIcon()
	segment6.switchIcon()
	segment7.switchIcon()
	segment8.switchIcon()
	segment9.switchIcon()
	segment10.switchIcon()
	segment11.switchIcon()
	segment12.switchIcon()
	segment13.switchIcon()

func leftButtonPressed():
	# <- 0 <- 1 <- 2 <- 0
	if currentFrame < 1: #currentFrame == 0
		L.frame = 2
		C.frame = 2
		R.frame = 2
		currentFrame = 2
	elif currentFrame == 1:
		L.frame = 0
		C.frame = 0
		R.frame = 0
		currentFrame = 0
	elif currentFrame == 2: #currentFrame == 2 or there's a problem
		L.frame = 1
		C.frame = 1
		R.frame = 1
		currentFrame = 1
	else:
		print("ERROR, unexpected currentFrame: ", currentFrame)
	pass
	
func rightButtonPressed():
	# -> 0 -> 1 -> 2 -> 0
	if currentFrame == 0: #currentFrame == 0
		L.frame = 1
		C.frame = 1
		R.frame = 1
		currentFrame = 1
	elif currentFrame == 1:
		L.frame = 2
		C.frame = 2
		R.frame = 2
		currentFrame = 2
	elif currentFrame == 2: #currentFrame == 0 or there's a problem
		L.frame = 0
		C.frame = 0
		R.frame = 0
		currentFrame = 0
	else:
		print("ERROR, unexpected currentFrame: ", currentFrame)
		
#the following functions move the tab highlight to the appropriate
#tab.
func questButtonPressed():
	highlight.set_position(Vector2(0,0))
	tabIndex = 0
	#TODO: change text in inventory section
	
func weaponButtonPressed():
	highlight.set_position(Vector2(55,0))
	tabIndex = 1
	#TODO: change text in inventory section
	
func equippableButtonPressed():
	highlight.set_position(Vector2(110,0))
	tabIndex = 2
	#TODO: change text in inventory section
	
func consumableButtonPressed():
	highlight.set_position(Vector2(165,0))
	tabIndex = 3
	
func miscButtonPressed():
	highlight.set_position(Vector2(220,0))
	tabIndex = 4
	#TODO: change text in inventory section
	
func mapButtonPressed():
	highlight.set_position(Vector2(275,0))
	tabIndex = 5
	#TODO: change text in inventory section
	
func itemSelected():
	isPopupUp = true
	optionPopup.show()
	match currentTab:
		"map":
			optionPopup.setText("set marker", "fast travel", "show on map")
			print("discovered place")
		"quests":
			#TODO: figure out what the 3 options should be
			optionPopup.setText("set marker", "make active", "choice tree")
			print("quest")
		"weapons":
			#TODO: change text based on whether the item is equipped
			optionPopup.setText("equip", "drop", "give to partner")
			print("weapon")
		"consumable":
			#TODO: change text based on whether the item is food, drugs, etc/
			optionPopup.setText("eat", "drop", "give to partner")
			print("consumable")
		"equippable":
			#TODO: change text based on whether the item is equipped
			optionPopup.setText("equip", "drop", "give to partner")
			print("equippable")
		_:
			#TODO: figure out what the 3 options should be
			optionPopup.setText("use", "drop", "give to partner")
			print("misc item")

#sets the text above the items
func setBasicText():
	get_node("Basic Info").currentTab = currentTab

#split the player's inventory into several arrays based on item type
func loadInventory(list):
	quests = []
	weaponItems = []
	equippableItems = []
	consumableItems = []
	miscItems = []
	discoveredPlaces = []
	for i in list:
		if i.itemType == "quest":
			quests.append(i)
		elif i.itemType == "weapon":
			weaponItems.append(i)
		elif i.itemType == "equippable":
			equippableItems.append(i)
		elif i.itemType == "consumable":
			consumableItems.append(i)
		elif i.itemType == "misc":
			miscItems.append(i)
		else: #i.itemType == "place":
			discoveredPlaces.append(i)
	print("inventory loaded")
	print("quests: " + str(quests))
	print("weapons: " + str(weaponItems))
	print("equippables: " + str(equippableItems))
	print("consumables: " + str(consumableItems))
	print("misc: " + str(miscItems))
	print("discovered places: " + str(discoveredPlaces))

#checks what tab the screen is on, and sets the inventory screen
#accordingly
func setInventorySegments():
	resetSegmentText()
	if currentTab == "quests":
		setSegments(quests)
	elif currentTab == "map":
		setSegments(discoveredPlaces)
	elif currentTab == "misc":
		setSegments(miscItems)
	elif currentTab == "consumable":
		setSegments(consumableItems)
	elif currentTab == "equippable":
		setSegments(equippableItems)
	else: #currentTab == "weapons":
		setSegments(weaponItems)
		

#takes an array of items and assigns them to the inventory segments
func setSegments(itemsArray):
	#print("setting segments with " + str(itemsArray))
	var item
	if itemsArray.size() > 14:
		for i in range(14):
			item = itemsArray[i]
			setIndividualSegment(item,i)
			#add all segments and be ready to scroll
	else:
		for i in range(0,itemsArray.size()):
			item = itemsArray[i]
			setIndividualSegment(item,i)
			#add to appropriate segments

#helper for setSegments to make the code cleaner
func setIndividualSegment(item, index):
	#print("setting indivudual segments at index " + str(index) + " and item " + str(item))
	if index == 0:
		segment0.setText(str(item))
	elif index == 1:
		segment1.setText(str(item))
	elif index == 2:
		segment2.setText(str(item))
	elif index == 3:
		segment3.setText(str(item))
	elif index == 4:
		segment4.setText(str(item))
	elif index == 5:
		segment5.setText(str(item))
	elif index == 6:
		segment6.setText(str(item))
	elif index == 7:
		segment7.setText(str(item))
	elif index == 8:
		segment8.setText(str(item))
	elif index == 9:
		segment9.setText(str(item))
	elif index == 10:
		segment10.setText(str(item))
	elif index == 11:
		segment11.setText(str(item))
	elif index == 12:
		segment12.setText(str(item))
	else: #index == 13:
		segment13.setText(str(item))
		
func resetSegmentText():
	segment0.setText("")
	segment1.setText("")
	segment2.setText("")
	segment3.setText("")
	segment4.setText("")
	segment5.setText("")
	segment6.setText("")
	segment7.setText("")
	segment8.setText("")
	segment9.setText("")
	segment10.setText("")
	segment11.setText("")
	segment12.setText("")
	segment13.setText("")

func loadTab():
	print("tab loaded")

#scroll all of the items up
func scrollUp():
	print("Scroll up")
	#go through the inventory and change text
	#change the icons of the segments to simulate actual scrolling
		
#move the highlight to the currentItem location
func moveHighlight():
	if currentItem == 0:
		segment0ButtonPressed()
	elif currentItem == 1:
		segment1ButtonPressed()
	elif currentItem == 2:
		segment2ButtonPressed()
	elif currentItem == 3:
		segment3ButtonPressed()
	elif currentItem == 4:
		segment4ButtonPressed()
	elif currentItem == 5:
		segment5ButtonPressed()
	elif currentItem == 6:
		segment6ButtonPressed()
	elif currentItem == 7:
		segment7ButtonPressed()
	elif currentItem == 8:
		segment8ButtonPressed()
	elif currentItem == 9:
		segment9ButtonPressed()
	elif currentItem == 10:
		segment10ButtonPressed()
	elif currentItem == 11:
		segment11ButtonPressed()
	elif currentItem == 12:
		segment12ButtonPressed()
	elif currentItem == 13:
		segment13ButtonPressed()
	
#scroll all of the items down
func scrollDown():
	print("Scroll down")
	#go through the inventory and change text
	#change the icons of the segments to simulate actual scrolling
		
#the following functions move the item highlight to the appropriate
#inventory segment, and in case the function is being called because
#of a click the currentItem is changed to be correct. If the function
#is called because of a key press, this is redundant, but it allows a
#player to navigate with both the keys and the mouse one after the other
func segment0ButtonPressed():
	itemHighlight.set_position(Vector2(0,0))
	currentItem = 0

func segment1ButtonPressed():
	itemHighlight.set_position(Vector2(0,25))
	currentItem = 1

func segment2ButtonPressed():
	itemHighlight.set_position(Vector2(0,50))
	currentItem = 2
	
func segment3ButtonPressed():
	itemHighlight.set_position(Vector2(0,75))
	currentItem = 3
	
func segment4ButtonPressed():
	itemHighlight.set_position(Vector2(0,100))
	currentItem = 4
	
func segment5ButtonPressed():
	itemHighlight.set_position(Vector2(0,125))
	currentItem = 5
	
func segment6ButtonPressed():
	itemHighlight.set_position(Vector2(0,150))
	currentItem = 6
	
func segment7ButtonPressed():
	itemHighlight.set_position(Vector2(0,175))
	currentItem = 7
	
func segment8ButtonPressed():
	itemHighlight.set_position(Vector2(0,200))
	currentItem = 8
	
func segment9ButtonPressed():
	itemHighlight.set_position(Vector2(0,225))
	currentItem = 9
	
func segment10ButtonPressed():
	itemHighlight.set_position(Vector2(0,250))
	currentItem = 10
	
func segment11ButtonPressed():
	itemHighlight.set_position(Vector2(0,275))
	currentItem = 11
	
func segment12ButtonPressed():
	itemHighlight.set_position(Vector2(0,300))
	currentItem = 12
	
func segment13ButtonPressed():
	itemHighlight.set_position(Vector2(0,325))
	currentItem = 13
	
func setOptionPopupLocation():
	var yVal = 306 + 18*currentItem
	optionPopup.set_position(Vector2(220,yVal))

func _process(delta):
	#TODO: add actual functionality to keybinds
	currentTab = tabs[tabIndex]
	setOptionPopupLocation()
	if self.is_visible_in_tree():
		if !isPopupUp:
			if Input.is_action_just_pressed(str(upKey)):
				if currentItem > 0: #not already the top
				#print("CurrentItem before press: " + str(currentItem))
				#if currentItem == topItem: #need to scroll up
				#	topItem = topItem - 1
				#	scrollUp()
					currentItem = currentItem - 1
					moveHighlight()
				#print("Current item after press: " + str(currentItem))
			if Input.is_action_just_pressed(str(downKey)):
				if currentItem < 13: #not already the bottom
				#print("CurrentItem before press: " + str(currentItem))
				#if currentItem == (topItem - 13): #need to scroll down
				#	topItem = topItem + 1
				#	scrollDown()
					currentItem = currentItem + 1
					moveHighlight()
				#print("Current item after press: " + str(currentItem))
			if Input.is_action_just_pressed(str(leftKey)):
				if currentTab == "quests":
					mapButtonPressed()
				elif currentTab == "map":
					miscButtonPressed()
				elif currentTab == "misc":
					consumableButtonPressed()
				elif currentTab == "consumable":
					equippableButtonPressed()
				elif currentTab == "equippable":
					weaponButtonPressed()
				else: #currentTab == "weapons":
					questButtonPressed()
			if Input.is_action_just_pressed(str(rightKey)):
				if currentTab == "quests":
					weaponButtonPressed()
				elif currentTab == "weapons":
					equippableButtonPressed()
				elif currentTab == "equippable":
					consumableButtonPressed()
				elif currentTab == "consumable":
					miscButtonPressed()
				elif currentTab == "misc":
					mapButtonPressed()
				else: #currentTab == "map"
					questButtonPressed()
			if Input.is_action_just_pressed(str(enterKey)):
				itemSelected()
		else:
			if Input.is_action_just_pressed(str(upKey)):
				optionPopup.upButtonPressed()
			if Input.is_action_just_pressed(str(downKey)):
				optionPopup.downButtonPressed()
			if Input.is_action_just_pressed(enterKey):
				optionPopup.enterButtonPressed()
				isPopupUp = false
			if Input.is_action_just_pressed(escKey):
				optionPopup.hide()
				isPopupUp = false
		setBasicText()
		setInventorySegments()
	pass