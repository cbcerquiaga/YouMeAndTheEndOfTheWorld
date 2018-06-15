extends TextureProgress

var health

func _ready():
	set_process(true)
	pass

func _process(delta):
	health = get_node("/root/Root/walls/player2").get("overallHealth")
	self.set_value(health)
	if(health <= 0):
		print("GAME OVER")
	pass
