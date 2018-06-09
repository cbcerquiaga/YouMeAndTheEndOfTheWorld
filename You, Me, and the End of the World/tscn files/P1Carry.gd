extends TextureProgress

var carryLeft
var carryWeight
var maxCarry

func _ready():
	set_process(true)
	pass

func _process(delta):
	carryWeight = get_node("/root/dungeon/walls/player1").get("carryWeight")
	maxCarry = get_node("/root/dungeon/walls/player1").get("maxCarry")
	carryLeft = ((maxCarry - carryWeight)/maxCarry)*100
	self.set_value(carryLeft)
	if(carryLeft >= 100):
		print("You are overloaded")
	pass