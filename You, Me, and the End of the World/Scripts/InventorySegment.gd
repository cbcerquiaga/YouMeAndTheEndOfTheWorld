extends Control

onready var sprite = get_node("Sprite")

func _ready():
	get_node("RichTextLabel").text = " "
	pass
	
func switchIcon():
	if sprite.frame == 0:
		sprite.frame = 1
	else: #Sprite.frame == 1:
		sprite.frame = 0
		
func setText(string):
	get_node("RichTextLabel").text = string

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
