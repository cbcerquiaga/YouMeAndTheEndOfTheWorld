extends KinematicBody2D

onready var goingLeft = false
onready var swimTimer = 100

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func swimLeft():
	move_and_slide(Vector2(-50, 0))
	
func swimRight():
	move_and_slide(Vector2(50,0))

func _process(delta):
	if goingLeft:
		swimLeft()
	else: #if goingRight:
		swimRight()
	if swimTimer == 0:
		goingLeft = !goingLeft
		#flipSprite()
		swimTimer = 300
		#TODO: randomize a bit
	else:
		swimTimer -= 1
	pass
