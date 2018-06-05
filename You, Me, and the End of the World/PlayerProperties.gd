
var itemList = Dictionary()

func addItem(item, name):
	if(itemList.has(item.itemName)):
		itemList[item.itemName] += 1
	else:
		itemList[item.itemName] = 1
	print('Added 1 ' , item.itemName , ' to ', name, '\'s inventory')

func str(name):
	if len(itemList) == 0:
		print(name, "\'s inventory is empty")
	else:
		var itemListKeys = itemList.keys()
		for i in range(0,itemListKeys.size()):
			if(itemList[itemListKeys[i]] == 1):
				print(itemList[itemListKeys[i]], ' ', itemListKeys[i])
			else:
				print(itemList[itemListKeys[i]], ' ', itemListKeys[i], 's')