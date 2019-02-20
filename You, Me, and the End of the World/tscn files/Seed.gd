extends KinematicBody2D

onready var motion = Vector2(2,0)
onready var speed = 800
onready var remainingTime = 200

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	translate((speed * motion * delta))
	remainingTime = remainingTime - 1
	if remainingTime == 0:
		speed = 0
	pass