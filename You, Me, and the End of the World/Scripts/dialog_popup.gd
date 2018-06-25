extends PopupMenu

func _ready():
	print("popup is up")
	self.clear()
	self.add_item("Dialog options")
	var vtrans = get_canvas_transform()
	var top_left = -vtrans.get_origin() / vtrans.get_scale()
	var vsize = get_viewport_rect().size
	self.set_position(top_left + 0.5 * vsize / vtrans.get_scale())
	self.connect("id_pressed", self, "_popupMenuChoice")

func load_Dialog(options):
	self.clear()
	for i in options:
		self.add_item(i)
	self.update()
	self.show()

func update():
	var vtrans = get_canvas_transform()
	var top_left = -vtrans.get_origin() / vtrans.get_scale()
	var vsize = get_viewport_rect().size
	self.set_position(top_left + 0.43 * vsize / vtrans.get_scale())

func _popupMenuChoice(ID):
	if ID == 0:
		print("Text 0")
	elif ID == 1:
		print("Text 1")
	elif ID == 2:
		print("Text 2")
	elif ID == 3:
		print("Text 3")
	elif ID == 4:
		print("Text 4")
	elif ID == 5:
		print("Text 5")
