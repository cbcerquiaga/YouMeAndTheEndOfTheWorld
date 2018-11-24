extends KinematicBody2D

onready var player1 = get_node("../boards/playerTeam/player1")
onready var player2 = get_node("../boards/playerTeam/player2")
onready var puck = get_node("../boards/puck")

func _ready():
	$Camera2D.zoom = Vector2(3, 3)
	pass

func _process(delta):
	#self.position = ((player1.position + player2.position + puck.position)/3)
	pass
