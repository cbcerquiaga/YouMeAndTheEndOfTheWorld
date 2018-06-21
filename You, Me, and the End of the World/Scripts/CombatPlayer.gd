extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var motion = Vector2()
	if Input.is_action_pressed("p1_move_up"):
		print("jump")
	if Input.is_action_pressed("p1_move_bottom"):
		print("crouch")
	if Input.is_action_pressed("p1_move_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("p1_move_right"):
		motion += Vector2(1, 0)
	if Input.is_action_pressed("p2_move_left"):#A
		print("grab")
	if Input.is_action_pressed("p2_action2"):#E
		print("head melee attack")
	if Input.is_action_pressed("p2_move_right"):#D
		print("body melee attack")
	if Input.is_action_pressed("p2_move_up"):#W
		print("head block")
	if Input.is_action_pressed("p2_move_down"):#S
		print("body block")
	if Input.is_action_pressed("ui_select"):#spacebar
		print("heavy melee attack")
	if Input.is_action_pressed("F key"):#F
		print("lunge attack")
	pass
