extends Popup

var currentItem
var highlight
var upButtonPressed
var downButtonPressed
var exitButtonPressed
var enterButtonPressed

onready var player1 = get_node("/root/World1/walls/player1")
onready var segment0 = get_node("Background/segment0")
onready var segment1 = get_node("Background/segment1")
onready var segment2 = get_node("Background/segment2")
onready var segment3 = get_node("Background/segment3")
onready var segment4 = get_node("Background/segment4")
onready var button0 = get_node("Background/segment0/Button")
onready var button1 = get_node("Background/segment1/Button")
onready var button2 = get_node("Background/segment2/Button")
onready var button3 = get_node("Background/segment3/Button")
onready var button4 = get_node("Background/segment4/Button")

signal drop_item_signal(player, index)

func _ready():
	currentItem = 0
	alternateSegmentFrames()
	highlight = get_node("Highlight")
	button0.connect("pressed",self,"button0Pressed")
	button1.connect("pressed",self,"button1Pressed")
	button2.connect("pressed",self,"button2Pressed")
	button3.connect("pressed",self,"button3Pressed")
	button4.connect("pressed",self,"button4Pressed")
	self.connect("drop_item_signal", player1, "_dropItem")
	pass
	
#func setButtons(_exit, _enter, _up, _down):
#	exitButtonPressed = Input.is_action_pressed(_exit)
#	enterButtonPressed = Input.is_action_pressed(_enter)
#	upButtonPressed = Input.is_action_pressed(_up)
#	downButtonPressed = Input.is_action_pressed(_down)

func setText(option0, option1, option2, option3, option4):
	segment0.setText(option0)
	segment1.setText(option1)
	segment2.setText(option2)
	segment3.setText(option3)
	segment4.setText(option4)
	pass

func upButtonPressed():
	if currentItem == 4:
		button3Pressed()
	elif currentItem == 3:
		button2Pressed()
	elif currentItem == 2:
		button1Pressed()
	else: #highlight is on 1 or 0
		button0Pressed()
			
func downButtonPressed():
	if currentItem == 0:
		button1Pressed()
	elif currentItem == 1:
		button2Pressed()
	elif currentItem == 2:
		button3Pressed()
	else: #highlight is 3 or 4
		button4Pressed()
	
func button0Pressed():
	if segment0.getText() != "" and segment0.getText() != " ":
		if currentItem != 0:
			highlight.set_position(Vector2(0,-57))
			currentItem = 0

func button1Pressed():
	if segment1.getText() != "" and segment1.getText() != " ":
		if currentItem != 1:
			highlight.set_position(Vector2(0,-30))
			currentItem = 1
#		else:
#			print("emit signal 1")
#			emit_signal("drop_item_signal", 1, 0) 
		#TODO: change 1st number to be current player, change second number
		#to actual index of the item in the player's inventory

func button2Pressed():
	if segment2.getText() != "" and segment2.getText() != " ":
		if currentItem != 2:
			highlight.set_position(Vector2(0,-3))
			currentItem = 2
		
func button3Pressed():
	if segment3.getText() != "" and segment3.getText() != " ":
		if currentItem != 3:
			highlight.set_position(Vector2(0,23))
			currentItem = 3

func button4Pressed():
	if segment4.getText() != "" and segment4.getText() != " ":
		if currentItem != 4:
			highlight.set_position(Vector2(0,50))
			currentItem = 4

func enterButtonPressed():
	if currentItem == 0:
		print("emit signal 0")
	elif currentItem == 1:
		print("emit signal 1")
	elif currentItem == 2:
		print("emit signal 2")
	elif currentItem == 3:
		print("emit signal 3")
	else: # currentItem == 4:
		print("emit signal 4")
	self.hide()

func alternateSegmentFrames():
	segment1.switchIcon()
	segment3.switchIcon()