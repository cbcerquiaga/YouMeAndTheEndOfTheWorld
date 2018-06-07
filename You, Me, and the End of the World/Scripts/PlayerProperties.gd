

var itemList = Dictionary()
var selectedItem = 0
const moveSpeed = 200

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

#initalizing playerProperties
func __init__(strength, fortitude, agility, charisma):
	self.strength = strength
	self.fortitude = fortitude
	self.agility = agility
	self.charisma = charisma

#Adds an item to inventory, if it is already in inventory then increment it's value by 1
#name just allows the player's name to be passed in for debugging purposes
func addItem(item, name):
	if(itemList.has(item.itemName)):
		itemList[item.itemName] += 1
	else:
		itemList[item.itemName] = 1
	print('Added 1 ' , item.itemName , ' to ', name, '\'s inventory')

#Removes an item from the inventory, if it is not in the inventory then does nothing
#Erases the item from inventory if the value is less than 1 as a result of the call
#name just allows the player's name to be passed in for debugging purposes
func removeItem(item, name):
	if(itemList.has(item.itemName)):
		itemList[item.itemName] -= 1
		if itemList[item.itemName] < 1:
			itemList.erase(item.itemName)
		print('Removed 1 ' , item.itemName , ' to ', name, '\'s inventory')

#Calculates the speed the player should be moving at, this should take into account
#perks, traits and default move speed
func getSpeed():
	return moveSpeed * speedBonus

func hasItem(item):
	return itemList.has(item)

#returns the selected item
func getSelectedItem():
	var keyList = itemList.keys()
	return keyList[selectedItem]

#returns the selected item's index in inventory
func getSelectedIndex():
	return selectedItem

#Searches the inventory for this string, returns -1 if it is not in the inventory
func selectItemByName(name):
	var keyList = itemList.keys()
	for i in range(len(keyList)):
		if(keyList[i].itemName == name):
			selectedItem = i
			return i
	return -1

#Returns an item at the index of the inventory
func selectItemByIndex(index):
	selectedItem = index

#A String representation of the player's inventory
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