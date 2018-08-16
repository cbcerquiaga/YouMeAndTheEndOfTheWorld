extends TextureProgress

var frame
onready var player1 = self.get_parent().get_parent().get_parent().get_node("walls/player1")

func _ready():
	pass

func _process(delta):
	frame = self.get_parent().get_parent().get("currentFrame")
	print(str(frame))
	if frame == 0:
		#WATER
		print("frame is " + str(frame))
		value = player1.playerProperty.water
	elif frame == 1:
		#COLD
		print("frame is " + str(frame))
		value = player1.playerProperty.cold
	else:
		#ADDICTION
		print("frame is " + str(frame))
		value = player1.playerProperty.addictionLevel
	self.set_value(value)
	pass
