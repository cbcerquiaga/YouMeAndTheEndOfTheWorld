extends KinematicBody2D

onready var player1 = get_parent().get_node("player1")
onready var player2 = get_parent().get_node("player2")

func _ready():
	pass

func _process(delta):
	#playerrs are not within combat range
	if ((self.global_position - player1.global_position).length() >= 100) and ((self.global_position - player2.global_position).length() >= 100):
		if((self.global_position - player1.global_position).length() < 300):
			self.move_and_slide(player1.global_position - self.global_position)
		elif((self.global_position - player2.global_position).length() < 300):
			self.move_and_slide(player2.global_position - self.global_position)
	else: #players are within combat range
		handle_collide(player1)
	pass

func handle_collide(player):
	get_tree().change_scene("res://tscn files/Combat.tscn")