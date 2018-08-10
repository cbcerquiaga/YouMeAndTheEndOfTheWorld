extends PopupMenu

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	pass


func _on_Piano_mouse_entered():
	clear()
	add_item("Piano")
	rect_position = get_global_mouse_position()
	show()
	pass # replace with function body


func _on_Piano_mouse_exited():
	hide()
	pass # replace with function body
