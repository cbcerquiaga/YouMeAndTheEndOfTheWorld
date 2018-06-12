extends 'item.gd'

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	__init__('GrandPiano', 100, "res://tscn files/Piano.tscn", "res://Scripts/Piano.gd")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
