extends AcceptDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func winner(winner):
	if winner == 'player':
		set_text("The enemy is defeated!")
	else:
		set_text("GAME OVER")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
