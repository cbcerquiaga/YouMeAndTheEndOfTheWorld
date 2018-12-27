extends KinematicBody2D

onready var puckPosition = Vector2(0,0)
var facingRight = true
const TOP_VALUE = 940
const BOTTOM_VALUE = 900
const LEFT_POS = -650
const RIGHT_POS = 0
const CHALLENGE = 150
const SLIDE_SPEED = 20
const POKE_SPEED = 50

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func setPuckPosition(newPosition):
	puckPosition = newPosition

func pokeCheck(delta):
	translate(POKE_SPEED * delta)
	
	

func _process(delta):
	self.look_at(puckPosition)
	if puckPosition.y < position.y:
		if position.y < TOP_VALUE:
			move_and_slide(Vector2(0, -SLIDE_SPEED))
		else:
			move_and_slide(Vector2(0,0))
	elif puckPosition.y > position.y:
		if position.y > BOTTOM_VALUE:
			move_and_slide(Vector2(0, SLIDE_SPEED))
		else:
			move_and_slide(Vector2(0,0))
#	if abs(puckPosition.x - position.x) < CHALLENGE/2:
#		pokeCheck(delta)
