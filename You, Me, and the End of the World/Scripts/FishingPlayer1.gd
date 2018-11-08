extends KinematicBody2D

var velocity = Vector2()
const SPEED = 150

signal p1CaughtFish

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func on_fish_caught():
	print("It's a big one")

func _process(delta):
	#var collideCheck = get_node("TileMap/Player1/Area2D").get_overlapping_bodies()
	var left = Input.is_action_pressed("p1_move_left")
	var right = Input.is_action_pressed("p1_move_right")
	var up = Input.is_action_pressed("p1_move_up")
	var down = Input.is_action_pressed("p1_move_down")
	
	if left:
		velocity.x = -SPEED
	elif right:
		velocity.x = SPEED
	elif !left and !right:
		velocity.x = 0
	if down:
		velocity.y = SPEED
	elif up:
		velocity.y = -SPEED
	elif !down and !up:
		velocity.y = 0
		
	if velocity != Vector2(0,0):
		move_and_slide(velocity)
		#emit_signal("move")
#	if collideCheck != null:
#		for i in collideCheck:
#			contact(i)
	pass
	
func contact(body):
	emit_signal("p1CaughtFish")
