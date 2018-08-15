extends PopupMenu

func _mouse_entered(item):
	var output = str(item.quantity, " ", item.itemName)
	if(item.quantity > 1):
		output = output + "s"
	add_item(output)
	rect_position = get_global_mouse_position()
	show()
	pass # replace with function body


func _mouse_exited(item):
	clear()
	hide()
	pass # replace with function body
