
var itemList = Dictionary()
var selectedItem = 0
var moveSpeed = 200

#TRAITS
var strength = 1
var fortitude = 1
var agility = 1
var charisma = 1

#PERKS
var firstStrikeChance = 0
var carryBonus = 0
var rerollChaBonus = 0
var randEncountBonus = 0
var sailOperator = 0
var scareBonus = 1
var knifeFightChance = 0
var speedBonus = 1
var hungerBonus = 1
var damageBonus = 1

func __init__(strength, fortitude, agility, charisma):
	self.strength = strength
	self.fortitude = fortitude
	self.agility = agility
	self.charisma = charisma
	

func addItem(item, name):
	if(itemList.has(item.itemName)):
		itemList[item.itemName] += 1
	else:
		itemList[item.itemName] = 1
	print('Added 1 ' , item.itemName , ' to ', name, '\'s inventory')
	

func removeItem(item, name):
	if(itemList.has(item.itemName)):
		itemList[item.itemName] -= 1
		if itemList[item.itemName] < 1:
			itemList.erase(item.itemName)
	
func getSpeed():
	return moveSpeed * speedBonus

func hasItem(item):
	return itemList.has(item)

func getSelectedItem():
	var keyList = itemList.keys()
	return keyList[selectedItem]

func getSelectedIndex():
	return selectedItem

func selectItemByName(name):
	var keyList = itemList.keys()
	for i in range(len(keyList)):
		if(keyList[i].itemName == name):
			selectedItem = i
			return i
	return -1

func selectItemByIndex(index):
	selectedItem = index

func str(name):
	if len(itemList) == 0:
		print(name, "\'s inventory is empty")
	else:
		print('Printing ', name, ' \'s inventory')
		var itemListKeys = itemList.keys()
		for i in range(0,itemListKeys.size()):
			if(itemList[itemListKeys[i]] == 1):
				print(itemList[itemListKeys[i]], ' ', itemListKeys[i])
			else:
				print(itemList[itemListKeys[i]], ' ', itemListKeys[i], 's')