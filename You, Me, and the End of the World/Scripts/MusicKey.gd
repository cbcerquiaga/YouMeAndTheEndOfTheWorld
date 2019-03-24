extends KinematicBody2D

onready var speed = 20
onready var sprite = get_node("Sprite")
var key
var assignedPlayer
var isLead = false
var waiting = true

func _ready():
	set_process(true)
	sprite.visible = true
	pass
	
func changeSpeed(newSpeed):
	speed = newSpeed
	
func setLead():
	isLead = true

#changes the sprite depending on which player and what value is passed
func changeTexture(value, player):
	if player == 2:
		assignedPlayer = 2
		if value == "A":
			sprite.frame = 0
			key = "A"
		elif value == "D":
			sprite.frame = 1
			key = "D"
		elif value == "S":
			sprite.frame = 2
			key = "S"
		else: #value == "W":
			sprite.frame = 3
			key = "W"
	else: #if player == 1:
		assignedPlayer = 1
		if value == "A":
			sprite.frame = 4
			key = "A"
		elif value == "D":
			sprite.frame = 5
			key = "D"
		elif value == "S":
			sprite.frame = 6
			key = "S"
		else: #value == "W":
			sprite.frame = 7
			key = "W"
			
func drestroy(timing):
	#playKillAnimation(timing)
	queue_free()
	
func playKillAnimation(timing):
	if timing == "too soon":
		#play the too soon animation
		pass
	elif timing == "too late":
		#play the too late animation
		pass
	elif timing == "just right":
		#play the just right animation
		pass
	else:
		#no animation
		pass

func _process(delta):
	if !waiting:
		move_and_slide(Vector2(0,speed))
	#changeTexture("D",1)
	pass
