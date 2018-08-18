extends TextureProgress

var frame
onready var player1 = self.get_parent().get_parent().get_parent().get_parent().get_node("walls/player1")

func _ready():
	pass

func _process(delta):
	frame = self.get_parent().get_parent().get("currentFrame")
#	print(str(frame))
	if frame == 0:
		#FOOD
#		print("frame is " + str(frame))
		value = player1.playerProperty.food
	elif frame == 1:
		#COMBAT HEALTH
#		print("frame is " + str(frame))
		value = player1.playerProperty.combatHealth
	else:
		#ILLNESS
#		print("frame is " + str(frame))
		value = player1.playerProperty.illness
	self.set_value(value)
	pass
