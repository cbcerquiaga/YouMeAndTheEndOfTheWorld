extends 'res://Scripts/Hunting AI/HuntingEnemy.gd'

#onready var playerPos = get_node("root/Hunting/TileMap/Player").position
var moveTime = 100
var lastMove

func _ready():
	velocityMultiplier = 5.5
	pass

func _process(delta):
	if moveTime <= 0:
		if position.x <= 0 or position.x >= 1032 or position.y <= 50 or position.y >= 312:
			if abs(location.x) - abs(position.x) < 50 or abs(location.y) - abs(position.y) < 50:
				var coinFlip = randi()%2
				if coinFlip == 0:
					runAwayLeft()
					lastMove = "runAwayLeft"
				else:
					runAwayRight()
					lastMove = "runAwayRight"
		elif abs(location.x) - abs(position.x) < 50 or abs(location.y) - abs(position.y) < 50:
			runDirectlyAway()
			lastMove = "runDirectlyAway"
		moveTime = 10
	else:
		if lastMove == "runAwayLeft":
			runAwayLeft()
		elif lastMove == "runAwayRight":
			runAwayRight()
		else: #lastMove == "runDirectlyAway"
			runDirectlyAway()
		moveTime = moveTime - 1
	#if self.x - 
	pass
