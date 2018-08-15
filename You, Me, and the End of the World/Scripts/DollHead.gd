extends 'item.gd'

func _ready():
	#Creates the item as specified in the item.gd class
	init__("Doll", 1, 1, 1, "res://tscn files/DollHead.tscn", "res://Scripts/DollHead.gd")