extends TextureProgress

var health
var maxHealthVal = 100

func _ready():
	set_process(true)
	pass

func _process(delta):
	health = get_node("/root/Root/walls/player1").playerProperty.overallHealth
	if(health < 0):
		self.set_value(0)
	elif(health > maxHealthVal):
		self.set_value(maxHealthVal)
	else:
		self.set_value(health)
	if(health <= 0):
		print("GAME OVER")
	pass
