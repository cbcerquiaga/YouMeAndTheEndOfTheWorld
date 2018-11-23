extends KinematicBody2D

var velocity = Vector2()
var ammoVal = 0
const SPEED = 600
onready var lostVal = 0
onready var spookVal = 0
onready var shotVal = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if lostVal < 0:
		lostVal = 0
	if spookVal < 0:
		spookVal = 0
	if shotVal < 0:
		shotVal = 0
	if Input.is_action_pressed("p1_move_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("p1_move_left"):
		velocity.x = -SPEED
	elif !Input.is_action_pressed("p1_move_right") and !Input.is_action_pressed("p1_move_left"): #neither is pressed
		velocity.x = 0
	if Input.is_action_pressed("p1_move_up"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("p1_move_down"):
		velocity.y = SPEED
	elif !Input.is_action_pressed("p1_move_up") and !Input.is_action_pressed("p1_move_down"): #neither is pressed
		velocity.y = 0
	move_and_slide(velocity)
	pass
