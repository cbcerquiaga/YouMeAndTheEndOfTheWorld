extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var player1 = get_node("/root/Root/walls/player1")
onready var player2 = get_node("/root/Root/walls/player2")
var screensize = Vector2(800, 600)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	self.position = ((player1.position + player2.position)/(2))# + (screensize/(2)))
	pass
