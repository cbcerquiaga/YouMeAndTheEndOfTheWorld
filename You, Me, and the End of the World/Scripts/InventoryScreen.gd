extends Popup

var justOpened
var L
var C
var R
var highlight
var currentFrame
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
	currentTab = tabs[tabIndex]
	L = get_node("Status Box/Left Icon")
	C = get_node("Status Box/Center Icon")
	R = get_node("Status Box/Right Icon")
	highlight = get_node("Tabs/Highlight")
#	print("Highlight position: " + str(highlight.get_position()))
	leftButton.connect("pressed",self,"leftButtonPressed")
	rightButton.connect("pressed",self,"rightButtonPressed")
	questButton.connect("pressed",self,"questButtonPressed")
	weaponButton.connect("pressed",self,"weaponButtonPressed")
	consumableButton.connect("pressed",self,"consumableButtonPressed")
	equippableButton.connect("pressed",self,"equippableButtonPressed")
	miscButton.connect("pressed",self,"miscButtonPressed")
	mapButton.connect("pressed",self,"mapButtonPressed")
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

func _process(delta):
	#TODO: add actual functionality to keybinds
	currentTab = tabs[tabIndex]
	if Input.is_action_just_pressed("p1_move_up"):
		print("Scroll up")
	if Input.is_action_just_pressed("p1_move_down"):
		print("Scroll down")
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
	pass