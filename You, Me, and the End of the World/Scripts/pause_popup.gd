extends PopupMenu

func _ready():
	print("popup is up")
	self.clear()
	self.add_item("Resume", 1)
	self.add_item("Save", 2)
	self.add_item("Load", 3)
	self.add_item("Settings",4)
	self.add_item("Main Menu",5)
	self.add_item("Quit Game",6)
	var vtrans = get_canvas_transform()
	var top_left = -vtrans.get_origin() / vtrans.get_scale()
	var vsize = get_viewport_rect().size
	self.set_position(top_left + 0.5 * vsize / vtrans.get_scale())
	self.connect("id_pressed", self, "_popupMenuChoice")
	pass


func _unpause():
	.hide()
	get_tree().paused = false
	print("Game unpaused")

func update():
	var vtrans = get_canvas_transform()
	var top_left = -vtrans.get_origin() / vtrans.get_scale()
	var vsize = get_viewport_rect().size
	self.set_position(top_left + 0.43 * vsize / vtrans.get_scale())

func _popupMenuChoice(ID):
	if ID == 1: #resume
		print("Resume button pressed")
		_unpause()
	elif ID == 2:
		print("Save button pressed")
	elif ID == 3:
		print("Load button pressed")
	elif ID == 4:
		print("Settings button pressed")
	elif ID == 5:
		print("Main Menu button pressed")
	elif ID == 6:
		print("Quit Game button pressed")
		
