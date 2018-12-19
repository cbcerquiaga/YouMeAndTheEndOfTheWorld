extends KinematicBody2D

onready var speed = 20
onready var sprite = get_node("Sprite")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func changeSpeed(newSpeed):
	speed = newSpeed

#changes the sprite depending on which player and what value is passed
func changeTexture(value, player):
	if player == 2:
		if value == "A":
			sprite.set_texture("res://Images/RhythmKeyA.png")
		elif value == "S":
			sprite.set_texture("res://Images/RhythmKeyS.png")
		elif value == "D":
			sprite.set_texture("res://Images/RhythmKeyD.png")
		else: #value == "W":
			sprite.set_texture("res://Images/RhythmKeyW.png")
	else: #if player == 1:
		if value == "A":
			sprite.set_texture("res://Images/RhythmKeyLeft.png")
		elif value == "S":
			sprite.set_texture("res://Images/RhythmKeyDown.png")
		elif value == "D":
			sprite.set_texture("res://Images/RhythmKeyRight.png")
		else: #value == "W":
			sprite.set_texture("res://Images/RhythmKeyUp.png")

func _process(delta):
	move_and_slide(Vector2(0,speed))
	pass
