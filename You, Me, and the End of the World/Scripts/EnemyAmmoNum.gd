extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	text = get_node("/root/Combat/TileMap/Enemy").get("ammoVal")
	pass
