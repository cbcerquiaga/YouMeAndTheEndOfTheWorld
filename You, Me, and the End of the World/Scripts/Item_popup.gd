extends PopupMenu

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
#	mouse_filter = MOUSE_FILTER_IGNORE 
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	pass


func _mouse_entered(name):
#	print(get_incoming_connections())
#	print("En ", name)
	add_item(name)
	rect_position = get_global_mouse_position()
	show()
	pass # replace with function body


func _mouse_exited(name):
#	print("Ex ", name)
	clear()
	hide()
	pass # replace with function body
