extends TextureProgress

onready var player = get_node("/root/Combat/TileMap/CombatPlayer")
var currentHealth
var maxHealthVal = 100

func _ready():
	set_process(true)
	update()

func _process(delta):
	pass

func update():
	currentHealth = player.totalHealth
	if(currentHealth < 0):
		self.set_value(0)
	elif(currentHealth > maxHealthVal):
		self.set_value(maxHealthVal)
	else:
		self.set_value(currentHealth)

func hit():
	update()