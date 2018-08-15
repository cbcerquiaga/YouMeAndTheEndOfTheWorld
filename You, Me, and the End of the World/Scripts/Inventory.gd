var itemList = Array()

#Tests completed
func add_item(item):
	#Gets the number in this stack
	#Sets the items number in stack to 1 so that it would be identical to other items of the same type
	if hasItem(item):
		var tempItem = item
		itemList.remove(getLocation(item))
		tempItem.quantity = tempItem.quantity + item.quantity
		itemList.append(tempItem)
	else:
		itemList.append(item)

#Tests completed
func remove_item(item, numberToRemove):
	var location = getLocation(item)
	var itemInArray = itemList[location]
	if location != -1 and itemInArray.quantity >= numberToRemove:
		if(itemInArray.quantity - numberToRemove == 0):
			itemList.remove(location)
		return true
	else:
		return false


#Tests completed
func isEmpty():
  if(len(itemList) == 0):
    return true
  return false

func getLocation(item):
	for i in range(len(itemList)):
		if(itemList[i].__eq__(item)):
			return i
	return -1

#Tests completed
func hasItem(item):
	for i in range(len(itemList)):
		if(itemList[i].__eq__(item)):
			return true
	return false

#Tests completed
func getSelectedItem(numberSelected):
	if numberSelected < 0 or numberSelected >= len(itemList):
		return -1
	return itemList[numberSelected]

func selectItemByName(name):
	for i in range(len(itemList)):
		if(itemList[i].itemName == name):
			return i
	return -1

#Tests Completed
func numberOfItems():
	var sum = 0
	for i in range(len(itemList)):
		sum = sum + itemList[i].quantity
	return sum

func getTotalWeight():
	var sum = 0
	for i in itemList:
		sum = sum + i.weight
	return sum

#A string representation of the inventory
#Not really testable, can easily change. 
func str(name):
	if len(itemList) == 0:
		print(name, "\'s inventory is empty")
	else:
		print('Printing ', name, ' \'s inventory')
		print('Total weight: ' , getTotalWeight())
		var itemListKeys = len(itemList)
		for i in range(len(itemList)):
			if(itemList[itemListKeys[i]] == 1):
				print(itemList[itemListKeys[i]], ' ', itemListKeys[i].itemName)
			else:
				print(itemList[itemListKeys[i]], ' ', itemListKeys[i].itemName, 's')