extends "res://Scripts/CombatAI/CombatEnemy.gd"

var maxDistance
var minDistance
var middlePoint
var speed = 1.0 #1.0 is the same as the player
var movement
onready var player = get_node("../CombatPlayer")
onready var force = Vector2(0, GRAVITY)

func _ready():
	maxDistance = 315# must be 3 apart to avoid glitching, 15 to avoid any glitching when forced to move
	minDistance = 300
	pass

func _physics_process(delta):
	staminaRegen()
	self.move_and_collide(Vector2(0,500)) #GRAVITY
	movement = Vector2(WALK_MAX_SPEED, 0) * speed
	var distanceToPlayer = (self.global_position - player.global_position)
	if(abs(distanceToPlayer.x) < minDistance):
		if(distanceToPlayer.x > 0):
			move_and_slide(movement)
		else:
			move_and_slide(-movement)
	elif(abs(distanceToPlayer.x) > maxDistance):
		if(distanceToPlayer.x < 0):
			move_and_slide(movement)
		else:
			move_and_slide(-movement)
	pass
