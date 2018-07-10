extends TextureProgress

var energy

func _ready():
	set_process(true)
	pass

func _process(delta):
	energy = get_node("/root/Combat/TileMap/Enemy").get("stamina")
	self.set_value(energy)
	if(energy <= 0):
		print("Tired AF")
	pass
