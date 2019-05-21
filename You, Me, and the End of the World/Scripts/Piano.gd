extends 'item.gd'

func _ready():
	#Creates the item as specified in the item.gd class
	__init__('GrandPiano', "misc", 100, 1, 1,
	"res://tscn files/Piano.tscn", "res://Scripts/Piano.gd", "res://Images/grandPiano.png", "An enormous, heavy musical instrument played with several black and white keys, and a traditional symbol of wealth and learned musical ability.")