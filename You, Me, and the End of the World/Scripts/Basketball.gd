extends Node2D

#onready var team1leftPlayer
#onready var team1rightPlayer
#onready var team2leftPlayer
#onready var team2rightPlayer
onready var ball = get_node("TileMap/ball")
onready var leftNet = get_node("TileMap/left hoop/net")
onready var rightNet = get_node("TileMap/right hoop/net")

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
	pass
