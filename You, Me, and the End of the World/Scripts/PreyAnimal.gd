extends 'res://Scripts/HuntingEnemy.gd'

#onready var playerPos = get_node("root/Hunting/TileMap/Player").position

func _ready():
	velocityMultiplier = 5.5
	pass

func _process(delta):
	#playerPos = get_node("root/Hunting/TileMap/Player").get(position)
	#runDirectlyAway(playerPos)
	runDirectlyAway()
	#if self.x - 
	pass
