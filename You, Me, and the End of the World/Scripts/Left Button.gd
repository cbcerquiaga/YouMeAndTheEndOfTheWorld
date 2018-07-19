extends Button

var L
var C
var R

func _ready():
	L = get_node("/root/Inventory/Status Box/Left Icon")
	C = get_node("/root/Inventory/Status Box/Center Icon")
	R = get_node("/root/Inventory/Status Box/Right Icon")
	pass
	
func _pressed():
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
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
