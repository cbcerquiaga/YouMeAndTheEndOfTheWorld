extends Popup

var currentItem
var highlight
var button0
var button1
var button2
var upButtonPressed
var downButtonPressed
var exitButtonPressed
var enterButtonPressed
var text0
var text1
var text2

onready var player1 = get_node("/root/World1/walls/player1")
onready var segment0 = get_node("Background/segment0")
onready var segment1 = get_node("Background/segment1")
onready var segment2 = get_node("Background/segment2")
onready var segment3 = get_node("Background/segment3")
onready var segment4 = get_node("Background/segment4")

signal drop_item_signal(player, index)

func _ready():
	currentItem = 0
	alternateSegmentFrames()
	highlight = get_node("Highlight")
#	button0 = get_node("Background/Segment0/Button0")
#	button1 = get_node("Background/Segment1/Button1")
#	button2 = get_node("Background/Segment2/Button2")
#	button0.connect("pressed",self,"button0Pressed")
#	button1.connect("pressed",self,"button1Pressed")
#	button2.connect("pressed",self,"button2Pressed")
#	text0 = get_node("Background/Segment0/RichTextLabel0")
#	text1 = get_node("Background/Segment1/RichTextLabel1")
#	text2 = get_node("Background/Segment2/RichTextLabel2")
	self.connect("drop_item_signal", player1, "_dropItem")
	pass
	
#func setButtons(_exit, _enter, _up, _down):
#	exitButtonPressed = Input.is_action_pressed(_exit)
#	enterButtonPressed = Input.is_action_pressed(_enter)
#	upButtonPressed = Input.is_action_pressed(_up)
#	downButtonPressed = Input.is_action_pressed(_down)

func setText(option0, option1, option2):
	segment0.setText(option0)
	segment1.setText(option1)
	segment2.setText(option2)
#	text1.text = option1
#	text2.text = option2
#	button0.text = option0
#	button1.text = option1
#	button2.text = option2
	pass

func upButtonPressed():
	if currentItem == 4:
		highlight.set_position(Vector2(0,23))
		currentItem = 3
	elif currentItem == 3:
		highlight.set_position(Vector2(0,-3))
		currentItem = 2
	elif currentItem == 2:
		highlight.set_position(Vector2(0,-30))
		currentItem = 1
	else: #highlight is on 1 or 0
		highlight.set_position(Vector2(0,-57))
		currentItem = 0
			
func downButtonPressed():
	if currentItem == 0:
		highlight.set_position(Vector2(0,-30))
		currentItem = 1
	elif currentItem == 1:
		highlight.set_position(Vector2(0,-3))
		currentItem = 2
	elif currentItem == 2:
		highlight.set_position(Vector2(0,23))
		currentItem = 3
	else: #highlight is 3 or 4
		highlight.set_position(Vector2(0,50))
		currentItem = 4
	
func button0Pressed():
	if currentItem != 0:
		highlight.set_position(Vector2(0,-22))
		currentItem = 0
	else:
		print("emit signal 0")

func button1Pressed():
	if currentItem != 1:
		highlight.set_position(Vector2(0,0))
		currentItem = 1
	else:
		print("emit signal 1")
		emit_signal("drop_item_signal", 1, 0) 
		#TODO: change 1st number to be current player, change second number
		#to actual index of the item in the player's inventory

func button2Pressed():
	if currentItem != 2:
		highlight.set_position(Vector2(0,22))
		currentItem = 2
	else:
		print("emit signal 2")

func enterButtonPressed():
	if currentItem == 0:
		print("emit signal 0")
	elif currentItem == 1:
		print("emit signal 1")
	else: # currentItem == 2:
		print("emit signal 2")
	self.hide()

func alternateSegmentFrames():
	segment1.switchIcon()
	segment3.switchIcon()