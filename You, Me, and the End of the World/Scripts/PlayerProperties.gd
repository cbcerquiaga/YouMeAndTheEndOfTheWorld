var Inventory = preload("res://Scripts/Inventory.gd").new()

var selectedItem = 0
const moveSpeed = 200

#TRAITS
var strength = 1
var fortitude = 1
var agility = 1
var charisma = 1

var overallHealth = 100

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

#STATUS
var combatHealth = 90 #TODO: import health from CombatPlayer
var food = 10 #TODO: reduce food value as time progresses
var water = 25 #TODO: reduce water value as time progresses and when in heat
var hot = 100 #TODO: reduce heat resistance value as time progresses in heat and when improperly dressed
var cold = 1 #TODO: reduce cold resistance value as time progresses in cold and when improperly dressed
var illness = 50 #TODO: reduce when poisoned or sick
var hygeine = 50 #TODO: reduce once a day
var sleepLevel = 10 #TODO: reduce as time progresses
var addictionLevel = 75 #TODO: reduce as time progresses if addicted

#initalizing playerProperties
func __init__(strength, fortitude, agility, charisma):
	self.strength = strength
	self.fortitude = fortitude
	self.agility = agility
	self.charisma = charisma

#Adds an item to inventory, if it is already in inventory then increment it's value by 1
#name just allows the player's name to be passed in for debugging purposes
func addItem(item, name):
	Inventory.add_item(item)
	print('Added ', item.quantity, ' ' , item.itemName , ' to ', name, '\'s inventory')

func isEmpty():
	return Inventory.isEmpty()

#Removes an item from the inventory, if it is not in the inventory then does nothing
#Erases the item from inventory if the value is less than 1 as a result of the call
#name just allows the player's name to be passed in for debugging purposes
func removeItem(item, name):
	var itemQuantity = item.quantity
	if(Inventory.remove_item(item, item.quantity)):
		print('Removed ', itemQuantity, ' ' , item.itemName , ' from ', name, '\'s inventory')
	else:
		print("ERROR removing", item.itemName, " from ", name, "\'s inventory'")
		
		
#same as regular remove item function but lets you pass in a quantity
func removeItemAmount(item, name, quantity):
	if quantity > item.quantity:
		quantity = item.quantity
	elif quantity < 0:
		quantity = 0
	if(Inventory.remove_item(item, quantity)):
		print('Removed ', quantity, ' ' , item.itemName , ' from ', name, '\'s inventory')
	else:
		print("ERROR removing", item.itemName, " from ", name, "\'s inventory'")

#Calculates the speed the player should be moving at, this should take into account
#perks, traits and default move speed
func getSpeed():
	return moveSpeed * speedBonus

func hasItem(item):
	return Inventory.hasItem(item)

#returns the selected item
func getSelectedItem():
	return Inventory.getSelectedItem(selectedItem)

#returns the selected item's index in inventory
func getSelectedIndex():
	return selectedItem

#Searches the inventory for this string, returns -1 if it is not in the inventory
func selectItemByName(item):
	var selectedValue = Inventory.selectItemByName(item)
	if(selectedValue != -1):
		self.selectedItem = selectedValue
	else:
		print("Error, ", item.__itemName , " is not in the inventory")

#Returns an item at the index of the inventory
func selectItemByIndex(index):
	selectedItem = index

func inventoryStr(name):
	Inventory.str(name)

# takes the minimum value of each of the player's statuses and returns it
func calculateHealth():
	var array = [combatHealth,food,water,hot,cold,illness,hygeine,sleepLevel,addictionLevel]
	var minVal = array[0]
	#min() only takes 2 arguments, need to go through the whole array to get min value
	for i in range (1, array.size()):
		minVal = min(minVal, array[i])
	overallHealth = minVal
