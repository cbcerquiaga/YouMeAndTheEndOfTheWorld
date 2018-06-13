var itemList = Dictionary()

#Tests completed
func add_item(item):
  if itemList.has(item):
    itemList[item] = itemList[item] + 1
  else:
    itemList[item] = 1

#Tests completed
func remove_item(item):
  if itemList.has(item):
    itemList[item] = itemList[item] - 1
    if(itemList[item] == 0):
      itemList.erase(item)
    return true
  else:
    return false

#Tests completed
func isEmpty():
  if(len(itemList.keys()) == 0):
    return true
  return false

#Tests completed
func hasItem(item):
  return itemList.has(item)

#Tests completed
func getSelectedItem(numberSelected):
	if numberSelected < 0 or numberSelected > numberOfItems()-1:
		return -1
	var keyList = itemList.keys()
	return keyList[numberSelected]

#Tests completed
func selectItemByName(name):
	var keyList = itemList.keys()
	for i in range(len(keyList)):
		if(keyList[i].itemName == name):
			return i
	return -1

#Tests Completed
func numberOfItems():
	return len(itemList)

#A string representation of the inventory
#Not really testable, can easily change. 
func str(name):
	if len(itemList) == 0:
		print(name, "\'s inventory is empty")
	else:
		print('Printing ', name, ' \'s inventory')
		var itemListKeys = itemList.keys()
		for i in range(0,itemListKeys.size()):
			if(itemList[itemListKeys[i]] == 1):
				print(itemList[itemListKeys[i]], ' ', itemListKeys[i].itemName)
			else:
				print(itemList[itemListKeys[i]], ' ', itemListKeys[i].itemName, 's')
