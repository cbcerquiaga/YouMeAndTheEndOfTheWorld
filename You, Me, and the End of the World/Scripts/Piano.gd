extends 'item.gd'

func _ready():
	#Creates the item as specified in the item.gd class
	init__('GrandPiano', "misc", 100, 1, 1,
	"res://tscn files/Piano.tscn", "res://Scripts/Piano.gd")