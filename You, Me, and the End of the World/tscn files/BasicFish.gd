extends KinematicBody2D

onready var goingLeft = false
onready var swimTimer = 100
onready var isCaught = false
var isCaughtBy

onready var player1 = get_node("../TileMap/Player1")
onready var player2 = get_node("../TileMap/Player2")

signal caught

func _ready():
	self.connect("caught", player1, "on_fish_caught")
	self.connect("caught", player2, "on_fish_caught")
	pass

func swimLeft():
	move_and_slide(Vector2(-50, 0))
	
func swimRight():
	move_and_slide(Vector2(50,0))

func contact(body):
	print("Hooked!")
	print(str(body))
	emit_signal("caught")
	isCaught = true
	if body == get_node("../TileMap/Player1/CollisionShape2D"): #player1's collisionShape
		isCaughtBy = 1
	else:
		isCaughtBy = 2

func followPlayer():
	if isCaughtBy == 1:
		print("lead the way, player 1")
	else:
		print("player 2 is the player for me")

func _process(delta):
	var collideCheck = get_node("Area2D").get_overlapping_bodies()
	if(collideCheck != null):
		for i in collideCheck:
			print("Deeelicious worms")
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
