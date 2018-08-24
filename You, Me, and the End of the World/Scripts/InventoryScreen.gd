extends Popup

var justOpened
var L
var C
var R
var highlight
var itemHighlight
var currentFrame
var currentItem
var topItem
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

func _ready():
	#self.queue_free()
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
	#segment0.connect("pressed",self,"segment0Pressed")
	pass

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

#sets the text above the items
func setBasicText():
	get_node("Basic Info").currentTab = currentTab

#scroll all of the items up
func scrollUp():
	print("Scroll up")
	#go through the inventory and change text
	#change the icons of the segments to simulate actual scrolling
		
#move the item highlight up
func highlightUp():
	#move the highlight
	if currentItem == 1:
		itemHighlight.setPosition(Vector2(0,0))
	elif currentItem == 2:
		itemHighlight.setPosition(Vector2(0,25))
	
#scroll all of the items down
func scrollDown():
	print("Scroll down")
	#go through the inventory and change text
	#change the icons of the segments to simulate actual scrolling

#move the item highlight down
func highlightDown():
	if currentItem == 0:
		itemHighlight.setPosition(Vector2(0,25))
	elif currentItem == 2:
		itemHighlight.setPosition(Vector2(0,50))

func _process(delta):
	#TODO: add actual functionality to keybinds
	currentTab = tabs[tabIndex]
	if Input.is_action_just_pressed("p1_move_up"):
		if currentItem > 0: #not already the top
			print("CurrentItem: " + str(currentItem))
			if currentItem == topItem: #need to scroll up
				topItem = topItem - 1
				scrollUp()
			currentItem = currentItem - 1
			highlightUp()
	if Input.is_action_just_pressed("p1_move_down"):
		if currentItem < 14: #not already the bottom
			print("CurrentItem: " + str(currentItem))
			if currentItem == (topItem - 13): #need to scroll down
				topItem = topItem + 1
				scrollDown()
			currentItem = currentItem + 1
			highlightDown()
	if Input.is_action_just_pressed("p1_move_left"):
		#print("Tab over left")
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
	if Input.is_action_just_pressed("p1_move_right"):
		#print("Tab over right")
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
	setBasicText()
	pass