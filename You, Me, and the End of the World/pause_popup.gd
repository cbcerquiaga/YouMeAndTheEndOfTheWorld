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
	#self.set_position(Vector2(100,100))
	self.connect("id_pressed", self, "_popupMenuChoice")
	self.show()
	print("popup is showing")
	pass


func _unpause():
	$pause_popup.hide()
	get_tree().paused = false
	print("Game unpaused")
	
func _popupMenuChoice(ID):
	if ID == 1: #resume
		print("Resume button pressed")
		unpause()
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
		
