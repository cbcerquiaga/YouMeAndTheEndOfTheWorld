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
			sprite.frame = 0
		elif value == "D":
			sprite.frame = 1
		elif value == "S":
			sprite.frame = 2
		else: #value == "W":
			sprite.frame = 3
	else: #if player == 1:
		if value == "A":
			sprite.frame = 4
		elif value == "D":
			sprite.frame = 5
		elif value == "S":
			sprite.frame = 6
		else: #value == "W":
			sprite.frame = 7

func _process(delta):
	move_and_slide(Vector2(0,speed))
	#changeTexture("D",1)
	pass
