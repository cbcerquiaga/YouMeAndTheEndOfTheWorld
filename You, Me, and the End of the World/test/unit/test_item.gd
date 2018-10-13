extends "res://addons/gut/test.gd"

var item1 = load("res://Scripts/item.gd").new()
var item2 = load("res://Scripts/item.gd").new()

func setup():
	item1.init__('Coin', "misc", 1, 0, 5, 'res://tscn files/coins.tscn', 'res://Scripts/coins.gd', "res://Images/iur-2.png", "Formerly US quarters, these are accepted as currency in more places than any other currency.")
	item2.init__("coins", "misc", 42, 0, 5, "", "", "", "Formerly US quarters, these are accepted as currency in more places than any other currency.")

func test_equality():
	assert_true(item1.itemName != item2.itemName, "item1 and item2 do not have the same name")
	assert_true(item1.itemType == item2.itemType, "item1 and item2 do not have the same type")
	assert_true(item1.worth != item2.worth, "item1 and item2 do not have the same worth")
	assert_true(item1.scriptPath == item2.scriptPath, "item1 and item2 have the same script path")
	assert_true(item1.packedScenePath == item2.packedScenePath, "item1 and item2 have the same scene path")
	
func teardown():
	item1.free()
	item2.free()
	