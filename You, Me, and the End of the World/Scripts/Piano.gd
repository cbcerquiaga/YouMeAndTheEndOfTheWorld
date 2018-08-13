extends 'item.gd'

func _ready():
	#Creates the item as specified in the item.gd class
	__init__('GrandPiano', 100, 1, 
	"res://tscn files/Piano.tscn", "res://Scripts/Piano.gd")