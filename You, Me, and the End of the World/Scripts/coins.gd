extends 'res://Scripts/stackedItem.gd'

func _ready():
	item.__init__('Coin', 1, 0, 'res://tscn files/coins.tscn', 'res://Scripts/coins.gd')
	self.__init__(item, 5)
	
	#This is to set the Label to display the number of items in this stack
	var children = self.get_children()
	for i in children:
		if i.name == 'Label':
			i.text = str(numberInStack)
	