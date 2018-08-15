extends Popup

var L
var C
var R
var highlight
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
	L = get_node("Status Box/Left Icon")
	C = get_node("Status Box/Center Icon")
	R = get_node("Status Box/Right Icon")
	highlight = get_node("Tabs/Highlight")
	print("Highlight position: " + str(highlight.get_position()))
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
	var currentFrame = L.getFrame()
	if currentFrame < 1: #currentFrame == 0
		L.setFrame(2)
		C.setFrame(2)
		R.setFrame(2)
	elif currentFrame == 1:
		L.setFrame(0)
		C.setFrame(0)
		R.setFrame(0)
	else: #currentFrame == 2 or there's a problem
		L.setFrame(1)
		C.setFrame(1)
		R.setFrame(1)
	pass
	
func rightButtonPressed():
	var currentFrame = L.getFrame()
	if currentFrame < 1: #currentFrame == 0
		L.setFrame(1)
		C.setFrame(1)
		R.setFrame(1)
	elif currentFrame == 1:
		L.setFrame(2)
		C.setFrame(2)
		R.setFrame(2)
	else: #currentFrame == 2 or there's a problem
		L.setFrame(0)
		C.setFrame(0)
		R.setFrame(0)
		
func questButtonPressed():
	highlight.set_position(Vector2(0,0))
	#TODO: change text in inventory section
	
func weaponButtonPressed():
	highlight.set_position(Vector2(55,0))
	#TODO: change text in inventory section
	
func equippableButtonPressed():
	highlight.set_position(Vector2(110,0))
	#TODO: change text in inventory section
	
func consumableButtonPressed():
	highlight.set_position(Vector2(165,0))
	
func miscButtonPressed():
	highlight.set_position(Vector2(220,0))
	#TODO: change text in inventory section
	
func mapButtonPressed():
	highlight.set_position(Vector2(275,0))
	#TODO: change text in inventory section

func _process(delta):
	#process stuff
	pass