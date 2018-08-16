extends Popup

var highlight
onready var weaponButton = get_node("Tabs/Weapons")
onready var consumableButton = get_node("Tabs/Consumable")
onready var equippableButton = get_node("Tabs/Equippable")
onready var miscButton = get_node("Tabs/Misc")
onready var carButton = get_node("Tabs/Customize car")

func _ready():
	highlight = get_node("Tabs/Highlight")
	weaponButton.connect("pressed",self,"weaponButtonPressed")
	consumableButton.connect("pressed",self,"consumableButtonPressed")
	equippableButton.connect("pressed",self,"equippableButtonPressed")
	miscButton.connect("pressed",self,"miscButtonPressed")
	pass
	
func weaponButtonPressed():
	highlight.set_position(Vector2(0,0))
	#TODO: change text in inventory section
	
func equippableButtonPressed():
	highlight.set_position(Vector2(60,0))
	#TODO: change text in inventory section
	
func consumableButtonPressed():
	highlight.set_position(Vector2(120,0))
	
func miscButtonPressed():
	highlight.set_position(Vector2(180,0))
	#TODO: change text in inventory section

func carButtonPressed():
	highlight.set_position(Vector2(240,0))
	#TODO: change screen to car customization

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
