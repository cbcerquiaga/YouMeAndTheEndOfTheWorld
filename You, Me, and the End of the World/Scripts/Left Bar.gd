extends TextureProgress

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var frame
onready var player1 = self.get_parent().get_parent().get_parent().get_node("walls/player1")

func _ready():
	pass

func _process(delta):
	frame = self.get_parent().get_parent().get("currentFrame")
	print(str(frame))
	if frame == 0:
		#SLEEP
		print("frame is " + str(frame))
		value = player1.playerProperty.sleepLevel
	elif frame == 1:
		#HOT
		print("frame is " + str(frame))
		value = player1.playerProperty.hot
	else:
		#HYGEINE
		print("frame is " + str(frame))
		value = player1.playerProperty.hygeine
	self.set_value(value)
	pass
