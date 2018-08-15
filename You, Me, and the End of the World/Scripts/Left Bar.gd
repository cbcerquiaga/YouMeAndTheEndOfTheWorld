extends TextureProgress

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var player1 = self.get_parent().get_parent().get_parent().get_node("walls/player1")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	#TODO: get the right variable depending on Left Icon's frame
	value = player1.playerProperty.sleepLevel
	self.set_value(value)
	pass
