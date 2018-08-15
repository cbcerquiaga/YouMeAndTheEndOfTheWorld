extends TextureProgress

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	#TODO: get the right variable depending on Left Icon's frame
	#value = get_node("/root/walls/player1").get("sleepLevel")
	value = 50#TEST
	self.set_value(value)
	pass
