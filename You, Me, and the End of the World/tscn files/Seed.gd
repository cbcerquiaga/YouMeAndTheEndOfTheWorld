extends KinematicBody2D

onready var motion = Vector2(0,0)
onready var speed = 300
onready var remainingTime = 40

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	#translate((speed * motion * delta))
	move_and_slide(Vector2(motion.x*speed,motion.y*speed))
	remainingTime = remainingTime - 1
	if remainingTime == 0:
		speed = 0
	pass