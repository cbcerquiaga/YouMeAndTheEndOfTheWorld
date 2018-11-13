extends KinematicBody2D

onready var player1 = get_node("/root/TileMap/Player1")
onready var player2 = get_node("/root/TileMap/Player2")
var hasReachedBottom = false
var scrollSpeed = 100

func _ready():
	$Camera2D.zoom = Vector2(1.0, 1.0)
	pass

func _process(delta):
	if !hasReachedBottom: #time to scroll down
		self.move_and_slide(Vector2(0, scrollSpeed))
	else: #time to scroll up
		self.move_and_slide(Vector2(0, -scrollSpeed))
	pass
