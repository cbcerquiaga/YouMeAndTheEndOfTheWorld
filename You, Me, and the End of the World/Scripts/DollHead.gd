extends 'item.gd'

func _ready():
	#Creates the item as specified in the item.gd class
	__init__("Doll", "consumable", 1, 1, 1, "res://tscn files/DollHead.tscn", "res://Scripts/DollHead.gd", "res://Images/head.png", "I dunno, man. It's creepy")