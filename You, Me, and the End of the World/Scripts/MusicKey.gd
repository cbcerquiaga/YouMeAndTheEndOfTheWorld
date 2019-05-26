extends Area2D

onready var speed = 3
onready var sprite = get_node("Sprite")
var key
onready var waiting

func _ready():
	set_process(true)
	#sprite.visible = true
	waiting = false
	pass
	
func changeSpeed(newSpeed):
	speed = newSpeed
	
func wait():
	waiting = true
	
func go():
	waiting = false


func destroy(timing):
	#playKillAnimation(timing)
	queue_free()
	
func playKillAnimation(timing):
	if timing == true:
		#play happy you did it animation
		pass
	else:
		#play sad you screwed up animation
		pass

func _process(delta):
	if !waiting:
		position = Vector2(position.x, position.y + speed)
	pass
