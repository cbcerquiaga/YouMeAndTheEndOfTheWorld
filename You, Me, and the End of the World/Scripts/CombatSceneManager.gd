extends Node2D

# class member variables go here, for example:
# var a = 2
var crosshair = load("res://Images/Crosshair.png")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	Input.set_custom_mouse_cursor(crosshair)
	pass

func _pause():
	print("Game paused")
	get_tree().paused = true
	$combat_pause.update()
	$combat_pause.show()
	
func _process(delta):
	if Input.is_action_pressed("pause"):
		_pause()
	pass
