extends Control

onready var sprite = get_node("Sprite")
onready var label = get_node("RichTextLabel")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func switchIcon():
	if sprite.frame == 0:
		sprite.frame = 1
	else: #Sprite.frame == 1:
		sprite.frame = 0
		
func setText(string):
	label.text = string

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
