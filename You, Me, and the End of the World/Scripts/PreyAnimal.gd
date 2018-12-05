extends 'res://Scripts/HuntingEnemy.gd'

#onready var playerPos = get_node("root/Hunting/TileMap/Player").position

func _ready():
	velocityMultiplier = 5.5
	pass

func _process(delta):
	if position.x <= 0 or position.x >= 1032 or position.y <= 50 or position.y >= 312:
		if abs(location.x) - abs(position.x) < 50 or abs(location.y) - abs(position.y) < 50:
			var coinFlip = randi()%2
			if coinFlip == 0:
				runAwayLeft()
			else:
				runAwayRight()
	elif abs(location.x) - abs(position.x) < 50 or abs(location.y) - abs(position.y) < 50:
		runDirectlyAway()
	#if self.x - 
	pass
