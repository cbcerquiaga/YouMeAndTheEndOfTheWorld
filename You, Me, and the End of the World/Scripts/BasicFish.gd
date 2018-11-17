extends KinematicBody2D

const SPEED = 250
onready var goingLeft = false
onready var swimTimer = 100
onready var isCaught = false
onready var velocity = Vector2(0,0)
var bodyFollowing
var distX
var distY

onready var player1 = get_node("../../Player1")
onready var player2 = get_node("../../Player2")

signal caught

func _ready():
	self.connect("caught", player1, "on_fish_caught")
	self.connect("caught", player2, "on_fish_caught")
	pass

func swimLeft():
	move_and_slide(Vector2(-SPEED, 0))
	
func swimRight():
	move_and_slide(Vector2(SPEED,0))

func contact(body):
	if !isCaught:
		print("Hooked!")
		print(str(body))
		emit_signal("caught")
		isCaught = true
		bodyFollowing = body
	
func followPlayer():
	distX = self.get_global_position().x - bodyFollowing.get_global_position().x
	distY = self.get_global_position().y - bodyFollowing.get_global_position().y
	if distX < -10:
		velocity.x = SPEED
	elif distX < 0:
		velocity.x = SPEED/3
	elif distX > 10:
		velocity.x = -SPEED
	elif distX > 0:
		velocity.x = -SPEED/3
	if distY < -10:
		velocity.y = SPEED
	elif distY < 0:
		velocity.y = SPEED/3
	elif distY > 10:
		velocity.y = -SPEED
	elif distY > 0:
		velocity.y = -SPEED/3
	move_and_slide(velocity)

func _process(delta):
	var collideCheck = get_node("Area2D").get_overlapping_bodies()
	if(collideCheck != null):
		for i in collideCheck:
			#print("Deeelicious worms")
			contact(i)
	#movement
	if !isCaught:
		if goingLeft:
			swimLeft()
		else: #if goingRight:
			swimRight()
		if swimTimer == 0:
			goingLeft = !goingLeft
			#flipSprite()
			swimTimer = 300
			#TODO: randomize a bit
		else:
			swimTimer -= 1
	else:
		#print("You caught me this time")
		followPlayer()
	pass
