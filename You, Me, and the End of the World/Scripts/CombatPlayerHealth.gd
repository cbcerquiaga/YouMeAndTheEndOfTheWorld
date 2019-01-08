extends TextureProgress

var currentPlayer = 1
onready var player = get_node("/root/Combat/TileMap/CombatPlayer")
onready var player2 = get_node("/root/Combat/TileMap/CombatPlayer2")
var currentHealth
var maxHealthVal = 100

func _ready():
	set_process(true)
	update()

func _process(delta):
	pass

func update():
	if currentPlayer == 1:
		currentHealth = player.totalHealth
	else:
		currentHealth = player2.totalHealth
	if(currentHealth < 0):
		self.set_value(0)
	elif(currentHealth > maxHealthVal):
		self.set_value(maxHealthVal)
	else:
		self.set_value(currentHealth)

func hit():
	update()
	
func switchPlayer():
	if currentPlayer == 1:
		currentPlayer = 2
	else:
		currentPlayer = 1