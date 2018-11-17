extends KinematicBody2D

onready var player1 = get_node("../TileMap/Player1")
onready var player2 = get_node("../TileMap/Player2")

var hasReachedBottom = false
var scrollSpeed = 100
var maxScrollSpeed = 150
var minScrollSpeed = 50

func _ready():
#	$Camera.zoom = Vector2(1.0, 1.0)
	pass

func _process(delta):
#if !hasReachedBottom: #time to scroll down
	#check if one of the players is at the bottom of the screen
	#if player1.y - camera.y > lowerLimit and player2.y - camera.y > upperLimit
	#or if player2.y - camera.y > lowerLimit and player1.y - camera.y > upperLimit
	#scroll down at maxScrollSpeed
	#elif player1.y - camera.y < upperLimit and player2.y - camera.y < upperLimit
	#or if player2.y - camera.y < upperLimit and player1.y - camera.y < upperLimit
	#scroll down at minScrollSpeed
	#else
	#scroll at scrollSpeed
#else:
	#scroll up at maxScrollSpeed
	pass
