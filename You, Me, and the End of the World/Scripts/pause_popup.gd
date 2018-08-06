extends Popup

onready var resumeButton = get_node("Resume Button")
onready var saveButton = get_node("Save Button")
onready var loadButton = get_node("Load Button")
onready var settingsButton = get_node("Settings Button")
onready var helpButton = get_node("Help Button")
onready var mainMenuButton = get_node("Main Menu Button")

func _ready():
	print("popup is up")
	#self.clear()
	#self.add_item("Resume", 1)
	#self.add_item("Save", 2)
	#self.add_item("Load", 3)
	#self.add_item("Settings",4)
	#self.add_item("Help",5)
	#self.add_item("Main Menu",6)
	#self.add_item("Quit Game",7)
	#var vtrans = get_canvas_transform()
	#var top_left = -vtrans.get_origin() / vtrans.get_scale()
	#var vsize = get_viewport_rect().size
	#self.set_position(top_left + 0.5 * vsize / vtrans.get_scale())
	#self.connect("id_pressed", self, "_popupMenuChoice")


func _unpause():
	.hide()
	get_tree().paused = false
	print("Game unpaused")
	
func saveMenu():
	#TODO: check whether the player is in a position to save
	#var canSave = getCanPlayerSave()
	var canSave = true
	if (canSave):
		#TODO: add a save screen
		print("You will be redirected to the save screen")
	else:
		print("All your saves are belong to us")
	
func loadMenu():
	#TODO: add a load screen
	print("You will be redirected to the load screen")
	
func settingsMenu():
	#TODO: add settings menu
	print("You will be redirected to the settings screen")
	
func helpMenu():
	#TODO: add help menu
	print("Assistance requested")
	
func mainMenuOptions():
	#TODO: add an options screen asking whether the player would like to
	#save and quit, quit without saving, or not quit
	print("Who would ever want to leave such a fun game?")

func quitGame():
	get_tree().quit()

#func update():
#	var vtrans = get_canvas_transform()
#	var top_left = -vtrans.get_origin() / vtrans.get_scale()
#	var vsize = get_viewport_rect().size
#	self.set_position(top_left + 0.43 * vsize / vtrans.get_scale())	

#func _popupMenuChoice(ID):
#	if ID == 1: #resume
#		print("Resume button pressed")
#		_unpause()
#	elif ID == 2:
#		print("Save button pressed")
#	elif ID == 3:
#		print("Load button pressed")
#	elif ID == 4:
#		print("Settings button pressed")
#	elif ID == 5:
#		print("Help button pressed")
#	elif ID == 6:
#		print("Main Menu button pressed")
#	elif ID == 7:
#		print("Quit Game button pressed")
		