extends TextureProgress

onready var player = get_node("/root/Hunting/TileMap/Player")

func _process(delta):
	set_value(player.shotVal)
	pass
