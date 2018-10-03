extends RichTextLabel

func _ready():
	#text = get_node("/root/Combat/TileMap/CombatPlayer").get("ammoVal")
	pass

func _process(delta):
	text = get_node("/root/Combat/TileMap/CombatPlayer").get("ammoVal")
	pass
