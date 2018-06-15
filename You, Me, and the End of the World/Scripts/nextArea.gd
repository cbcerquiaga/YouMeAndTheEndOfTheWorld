extends StaticBody2D

var opened = false

func handle_item_pickup(player):
	print("Next area")
	if(opened):
		self.get_tree().change_scene("res://tscn files/World1.tscn")
		opened = true
	else:
		self.get_tree().change_scene("res://tscn files/World2.tscn")
		opened = false
	