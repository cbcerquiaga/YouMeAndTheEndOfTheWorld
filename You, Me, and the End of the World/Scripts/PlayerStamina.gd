extends TextureProgress

var player = 1
var energy

func _ready():
	set_process(true)
	pass

func _process(delta):
	if player == 1:
		energy = get_node("/root/Combat/TileMap/CombatPlayer").get("stamina")
	else:
		energy = get_node("/root/Combat/TileMap/CombatPlayer2").get("stamina")
	self.set_value(energy)
	if(energy <= 0):
		print("Tired AF")
	pass

func switchPlayer():
	if player == 1:
		player = 2
	else:
		player = 1