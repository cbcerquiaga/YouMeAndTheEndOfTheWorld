extends Node2D

#onready var team1leftPlayer
#onready var team1rightPlayer
#onready var team2leftPlayer
#onready var team2rightPlayer
onready var ball = get_node("TileMap/ball")
onready var leftNet = get_node("TileMap/left hoop/net")
onready var rightNet = get_node("TileMap/right hoop/net")
onready var player1 = get_node("TileMap/player1")
onready var player2 = get_node("TileMap/player2")
#onready var ai1 = get_node("TileMap/ai1")
#onready var ai2 = get_node("TileMap/ai2")

var hoopMouse = load("res://Images/bballCrosshair.png")

#point values for the game. These can be adjusted to 2pters and 1pters and a longer or shorter game if we want
const targetScore = 21
const longShot = 3
const tippedShot = 2

var team1Score = 0
var team2Score = 0
var teamTurn = 1 #1 for team 1, 2 for team 2
var isLeftShooting = true #true when shooting from the left, false when shooting from the right
var ballDeflected = false #true when the non-shooter for the offensive team has touched the ball, reducing the shot from a 3 to a 2
var alreadyScored = false #this will let us have a complete ball passing through the hoop animation without screwing up the score



# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(hoopMouse)
	#make the players fac the right way
	player1.updateFacingRight(false)
	player2.updateFacingRight(true)
	#flip a coin to see who shoots first
	#start the game
	pass


func _process(delta):
	if !isLeftShooting and leftNet.overlaps_body(ball):
		#if ball is moving down:
			print("Scoar!")
	elif isLeftShooting and rightNet.overlaps_body(ball):
		#if ball is moving down:
			print("Scoar!")
	#check who can catch the ball
	if player1.catchArea.overlaps_body(ball) and player1.canCatchBall:
		if !ball.isHeld:
			if ball.holdingPlayer != null:
				ball.holdingPlayer.canCatchBall = true
			ball.isHeld = true
			ball.holdingPlayer = player1
	if player2.catchArea.overlaps_body(ball) and player2.canCatchBall:
		if !ball.isHeld:
			if ball.holdingPlayer != null:
				ball.holdingPlayer.canCatchBall = true
			ball.isHeld = true
			ball.holdingPlayer = player2
			
	#left team 1 turn, right team 1 turn, left team 2 turn, right team 2 turn
	#shot clock goes
	#if shot clock doesn't expire, ball is shot or stolen
	#live ball timer goes
	#next turn
	#repeat
	pass
