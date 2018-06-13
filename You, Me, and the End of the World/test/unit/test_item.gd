extends "res://addons/gut/test.gd"

var Inventory = preload("res://Scripts/Inventory.gd").new()
var item1 = load("res://Scripts/item.gd").new()
var item2 = load("res://Scripts/item.gd").new()
var item3 = load("res://Scripts/item.gd").new()
var item4 = load("res://Scripts/item.gd").new()
var item5 = load("res://Scripts/item.gd").new()

func test_loading_items():
	item1.__init__('GrandPiano', 100, "res://tscn files/Piano.tscn", "res://Scripts/Piano.gd")
	item2.__init__('Keyboard', 50, "", "")
	item3.__init__('Banana', 5, "", "")
	item4.__init__('VR Headset', 500, "", "")
	item5.__init__('Google Glass', 5000, "", "")
	print("Testing loading items")
	#Adding items to the inventory
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
	assert_true(Inventory.numberOfItems() == 5, "The number of items in the inventory should be 5")


func test_searching_methods():
	var item6 = load("res://Scripts/item.gd").new()
	item6.__init__("Piano", 0, "", "")
	var item7 = load("res://Scripts/item.gd").new()
	item7.__init__("banana", 0, "", "")
	var item8 = load("res://Scripts/item.gd").new()
	item8.__init__("Google Glass", 500, "", "")
	var item9 = load("res://Scripts/item.gd").new()
	item9.__init__("keyboard", 50, "", "")
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
	
	assert_true(Inventory.getSelectedItem(5) == -1, "Index 5 should not contain any items")
	assert_true(Inventory.getSelectedItem(-1) == -1, "Index -1 should not contain any items")
	
	assert_true(Inventory.selectItemByName("GrandPiano") == 0, "The location of the GrandPiano in Inventory should be 0")
	assert_true(Inventory.selectItemByName("Keyboard") == 1, "The location of the Keyboard in Inventory should be 1")
	assert_true(Inventory.selectItemByName("Banana") == 2, "The location of the Banana in Inventory should be 2")
	assert_true(Inventory.selectItemByName("VR Headset") == 3, "The location of the VR Headset in Inventory should be 3")
	assert_true(Inventory.selectItemByName("Google Glass") == 4, "The location of the Google Glass in Inventory should be 4")
	assert_true(Inventory.selectItemByName("grandPiano") == -1, "The name of objects should be case sensitive, so grandPiano is not in the Inventory")
	assert_true(Inventory.selectItemByName("VRHeadset") == -1, "VRHeadset != VR Headset")

func test_removing_items():
	print("Testing removing items")
	
	#Removing items from the inventory
	Inventory.remove_item(item1)
	Inventory.remove_item(item2)
	Inventory.remove_item(item3)
	Inventory.remove_item(item4)
	Inventory.remove_item(item5)
	
	#Test the inventory
	assert_true(Inventory.isEmpty(), "Inventory should be empty")
	assert_true(!Inventory.hasItem(item1), "Item1 should not be in inventory")
	assert_true(!Inventory.hasItem(item2), "Item2 should not be in inventory")
	assert_true(!Inventory.hasItem(item3), "Item3 should not be in inventory")
	assert_true(!Inventory.hasItem(item4), "Item4 should not be in inventory")
	assert_true(!Inventory.hasItem(item5), "Item5 should not be in inventory")
	assert_true(Inventory.numberOfItems() == 0, "The number of items in the inventory should be 0")
