extends Popup

var L
var C
var R
onready var leftButton = get_node("Status Box/Left Button")
onready var rightButton = get_node("Status Box/Right Button")

func _ready():
	self.queue_free()
	L = get_node("Status Box/Left Icon")
	C = get_node("Status Box/Center Icon")
	R = get_node("Status Box/Right Icon")
	leftButton.connect("pressed",self,"leftButtonPressed")
	rightButton.connect("pressed",self,"rightButtonPressed")
	pass

func leftButtonPressed():
	var currentFrame = L.getFrame()
	if currentFrame < 1: #currentFrame == 0
		L.setFrame(2)
		C.setFrame(2)
		R.setFrame(2)
	elif currentFrame == 1:
		L.setFrame(0)
		C.setFrame(0)
		R.setFrame(0)
	else: #currentFrame == 2 or there's a problem
		L.setFrame(1)
		C.setFrame(1)
		R.setFrame(1)
	pass
	
func rightButtonPressed():
	var currentFrame = L.getFrame()
	if currentFrame < 1: #currentFrame == 0
		L.setFrame(1)
		C.setFrame(1)
		R.setFrame(1)
	elif currentFrame == 1:
		L.setFrame(2)
		C.setFrame(2)
		R.setFrame(2)
	else: #currentFrame == 2 or there's a problem
		L.setFrame(0)
		C.setFrame(0)
		R.setFrame(0)

func _process(delta):
	#process stuff
	pass