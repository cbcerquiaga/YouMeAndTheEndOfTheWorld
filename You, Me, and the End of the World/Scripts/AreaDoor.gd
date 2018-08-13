extends StaticBody2D

#Signals when the player presses 
func handle_item_pickup(player):
	get_tree().change_scene("res://tscn files/World2")