extends RichTextLabel

var player = 1

func _ready():
	#text = get_node("/root/Combat/TileMap/CombatPlayer").get("ammoVal")
	pass

func _process(delta):
	if player == 1:
		text = get_node("/root/Combat/TileMap/CombatPlayer").get("ammoVal")
	else:
		text = get_node("/root/Combat/TileMap/CombatPlayer2").get("ammoVal")
	pass

func switchPlayer():
	if player == 1:
		player = 2
	else:
		player = 1