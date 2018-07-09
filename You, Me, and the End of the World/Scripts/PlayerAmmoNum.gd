extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#text = get_node("/root/Combat/TileMap/CombatPlayer").get("ammoVal")
	pass

func _process(delta):
	text = get_node("/root/Combat/TileMap/CombatPlayer").get("ammoVal")
	pass
