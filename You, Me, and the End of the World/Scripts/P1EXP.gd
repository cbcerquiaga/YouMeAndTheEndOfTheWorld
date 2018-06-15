extends TextureProgress

var currentEXP

func _ready():
	set_process(true)
	pass

func _process(delta):
	currentEXP = get_node("/root/Root/walls/player1").get("currentEXP")
	self.set_value(currentEXP)
	if(currentEXP >= 100):
		print("LEVEL UP")
	pass

