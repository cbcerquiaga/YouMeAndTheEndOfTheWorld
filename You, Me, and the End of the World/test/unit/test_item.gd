extends "res://addons/gut/test.gd"

var item1 = load("res://Scripts/item.gd").new()
var item2 = load("res://Scripts/item.gd").new()

func setup():
	item1.init__("Coins", "misc", 50, 0, 5, "", "")
	item2.init__("coins", "misc", 42, 0, 5, "", "")

func test_equality():
	assert_true(item1.itemName != item2.itemName, "item1 and item2 do not have the same name")
	assert_true(item1.itemType == item2.itemType, "item1 and item2 do not have the same type")
	assert_true(item1.worth != item2.worth, "item1 and item2 do not have the same worth")
	assert_true(item1.scriptPath == item2.scriptPath, "item1 and item2 have the same script path")
	assert_true(item1.packedScenePath == item2.packedScenePath, "item1 and item2 have the same scene path")
	
func teardown():
	item1.free()
	item2.free()
	