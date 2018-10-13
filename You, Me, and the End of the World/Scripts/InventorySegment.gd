extends Control

onready var sprite = get_node("Sprite")
var item

func _ready():
	get_node("RichTextLabel").text = ""
	resetItem()
	pass
	
func switchIcon():
	if sprite.frame == 0:
		sprite.frame = 1
	else: #Sprite.frame == 1:
		sprite.frame = 0
		
func setText(string):
	get_node("RichTextLabel").text = string

func getText():
	return get_node("RichTextLabel").text
	
func getImage():
	if item != null:
		return item.imagePath
	
func itemDescription():
	if item != null:
		return item.description
	else:
		return ""
	
func resetItem():
	item = null

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
