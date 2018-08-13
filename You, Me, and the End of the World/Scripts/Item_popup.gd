extends PopupMenu

func _mouse_entered(name):
	add_item(name)
	rect_position = get_global_mouse_position()
	show()
	pass # replace with function body


func _mouse_exited(name):
	clear()
	hide()
	pass # replace with function body
