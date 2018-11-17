extends KinematicBody2D

onready var player1 = get_node("../TileMap/Player1")
onready var player2 = get_node("../TileMap/Player2")
onready var bottomDetection = get_node("BottomDetection")

var hasReachedBottom = false
var scrollSpeed = 100
var gameOver = false

func _ready():
	$Camera2D.zoom = Vector2(1.5, 1.5)
	pass

func _process(delta):
	var bodies = bottomDetection.get_overlapping_areas()
	if !bodies.empty():
		for i in bodies:
			if i.name == "BottomCheck":
				hasReachedBottom = true
			if i.name == "TopCheck" and hasReachedBottom:
				#GAME OVER CONDITIONS
				gameOver = true
				print("Game over")
	if !gameOver:
		if !hasReachedBottom: #time to scroll down
			self.move_and_slide(Vector2(0, scrollSpeed))
		else: #time to scroll up
			self.move_and_slide(Vector2(0, -scrollSpeed))
	pass
