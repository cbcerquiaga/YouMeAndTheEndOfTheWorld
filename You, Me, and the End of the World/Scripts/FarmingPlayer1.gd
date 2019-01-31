extends KinematicBody2D

var velocity = Vector2()
var isFrozen = false
const SPEED = 250
var heldItem
var isFacingRight= false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	var left = Input.is_action_pressed("p1_move_left")
	var right = Input.is_action_pressed("p1_move_right")
	var up = Input.is_action_pressed("p1_move_up")
	var down = Input.is_action_pressed("p1_move_down")
	if !isFrozen:
		if left:
			velocity.x = -SPEED
			#TODO: update facing right
		elif right:
			velocity.x = SPEED
			#TODO: update facing right
		elif !left and !right:
			velocity.x = 0
		if down:
			velocity.y = SPEED
		elif up:
			velocity.y = -SPEED
		elif !up and !down:
			velocity.y = 0
	if velocity != Vector2(0,0):
		move_and_slide(velocity)
		
	#if Input.is_action_pressed("p1_action1"):
		#useItem()
	#if Input.is_action_pressed("p1_action2"):
		#swap the item if near the bench
	pass
