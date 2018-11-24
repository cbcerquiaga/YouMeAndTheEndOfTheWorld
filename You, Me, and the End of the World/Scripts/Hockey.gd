extends Node2D

onready var camera = get_node("playerTracker/Camera2D")

func _ready():
	camera.make_current()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
