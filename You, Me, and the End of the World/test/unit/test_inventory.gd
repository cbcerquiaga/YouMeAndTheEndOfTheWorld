extends "res://addons/gut/test.gd"

var Inventory = load("res://Scripts/Inventory.gd").new()
var item1 = load("res://Scripts/item.gd").new()
var item2 = load("res://Scripts/item.gd").new()
var item3 = load("res://Scripts/item.gd").new()
var item4 = load("res://Scripts/item.gd").new()
var item5 = load("res://Scripts/item.gd").new()
var item6 = load("res://Scripts/item.gd").new()
var item7 = load("res://Scripts/item.gd").new()
var item8 = load("res://Scripts/item.gd").new()
var item9 = load("res://Scripts/item.gd").new()

var item10 = load("res://Scripts/item.gd").new()

func setup():
	item1.init__('GrandPiano', "misc", 100, 1, 1, "res://tscn files/Piano.tscn", "res://Scripts/Piano.gd")
	item2.init__('Keyboard', "misc", 50, 2, 1, "", "")
	item3.init__('Banana', "consumable", 5, 1, 1, "", "")
	item4.init__('VR Headset', "equippable", 500, 1, 1, "", "")
	item5.init__('Google Glass', "equippable", 5000, 5, 1, "", "")
	#print("Testing loading items")
	#Adding items to the inventory
	item6.init__("Piano", "misc", 0, 0, 1, "", "")
	item7.init__("banana", "consumable", 0, 0, 1, "", "")
	item8.init__("Google Glass", "equippable", 500, 0, 1, "", "")
	item9.init__("keyboard", "misc", 50, 0, 1, "", "")
	
	item10.init__("coin", "misc", 1, 0, 1, "", "")

func test_loading_items():
	Inventory.add_item(item1)
	Inventory.add_item(item2)
	Inventory.add_item(item3)
	Inventory.add_item(item4)
	Inventory.add_item(item5)
	
	#Test the inventory
	assert_true(!Inventory.isEmpty(), "Inventory should be not empty")
	assert_true(Inventory.hasItem(item1), "Item1 should be in inventory")
	assert_true(Inventory.hasItem(item2), "Item2 should be in inventory")
	assert_true(Inventory.hasItem(item3), "Item3 should be in inventory")
	assert_true(Inventory.hasItem(item4), "Item4 should be in inventory")
	assert_true(Inventory.hasItem(item5), "Item5 should be in inventory")
	assert_true(Inventory.numberOfItems() == 5, "The number of items in the inventory should be 39")


func test_searching_methods():
	assert_true(Inventory.hasItem(item1), "Inventory should have item1")
	assert_true(Inventory.hasItem(item2), "Inventory should have item2")
	assert_true(Inventory.hasItem(item3), "Inventory should have item3")
	assert_true(Inventory.hasItem(item4), "Inventory should have item4")
	assert_true(Inventory.hasItem(item5), "Inventory should have item5")
	
	assert_false(Inventory.hasItem(item6), "Inventory should not have item 6")
	assert_false(Inventory.hasItem(item7), "Inventory should not have item 7")
	assert_false(Inventory.hasItem(item8), "Inventory should not have item 8")
	assert_false(Inventory.hasItem(item9), "Inventory should not have item 9")
	
	assert_true(Inventory.getSelectedItem(0) == item1, "Index 0 should have item1")
	assert_true(Inventory.getSelectedItem(1) == item2, "Index 1 should have item2")
	assert_true(Inventory.getSelectedItem(2) == item3, "Index 2 should have item3")
	assert_true(Inventory.getSelectedItem(3) == item4, "Index 3 should have item4")
	assert_true(Inventory.getSelectedItem(4) == item5, "Index 4 should have item5")
#	assert_(Inventory.getSelectedItem(5) == item10, "Index 5 should have item10")
	
	assert_true(Inventory.getSelectedItem(5) == -1, "Index 5 should not contain any items")
	assert_true(Inventory.getSelectedItem(-1) == -1, "Index -1 should not contain any items")
	
	assert_true(Inventory.selectItemByName("GrandPiano") == 0, "The location of the GrandPiano in Inventory should be 0")
	assert_true(Inventory.selectItemByName("Keyboard") == 1, "The location of the Keyboard in Inventory should be 1")
	assert_true(Inventory.selectItemByName("Banana") == 2, "The location of the Banana in Inventory should be 2")
	assert_true(Inventory.selectItemByName("VR Headset") == 3, "The location of the VR Headset in Inventory should be 3")
	assert_true(Inventory.selectItemByName("Google Glass") == 4, "The location of the Google Glass in Inventory should be 4")
	assert_true(Inventory.selectItemByName("grandPiano") == -1, "The name of objects should be case sensitive, so grandPiano is not in the Inventory")
	assert_true(Inventory.selectItemByName("VRHeadset") == -1, "VRHeadset != VR Headset")
#	assert_true(Inventory.selectItemByName("coin") == 5, "The location of the coin should be in index 5")

func test_total_weight():
	assert_true(Inventory.getTotalWeight() == 10, "The inventory's total weight should be 10")
	assert_true(Inventory.getTotalWeight() != 1, "The inventory's total weight should not be 1")

func test_removing_items():
	#print("Testing removing items")
	
	#Removing items from the inventory
	Inventory.remove_item(item1, 1)
	Inventory.remove_item(item2, 1)
	Inventory.remove_item(item3, 1)
	Inventory.remove_item(item4, 1)
	Inventory.remove_item(item5, 1)
	
	#Test the inventory
	assert_true(Inventory.isEmpty(), "Inventory should be empty")
	assert_true(!Inventory.hasItem(item1), "Item1 should not be in inventory")
	assert_true(!Inventory.hasItem(item2), "Item2 should not be in inventory")
	assert_true(!Inventory.hasItem(item3), "Item3 should not be in inventory")
	assert_true(!Inventory.hasItem(item4), "Item4 should not be in inventory")
	assert_true(!Inventory.hasItem(item5), "Item5 should not be in inventory")
	assert_true(Inventory.numberOfItems() == 0, "The number of items in the inventory should be 0")