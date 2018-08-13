extends "res://addons/gut/test.gd"

var item1 = load("res://Scripts/item.gd").new()
var item2 = load("res://Scripts/item.gd").new()

func setup():
	item1.__init__("Coins", 50, 0, "", "")
	item2.__init__("coins", 42, 0, "", "")

func test_equality():
	assert_true(item1.__itemName != item2.__itemName, "item1 and item2 do not have the same name")
	assert_true(item1.__worth != item2.__worth, "item1 and item2 do not have the same worth")
	assert_true(item1.__scriptPath == item2.__scriptPath, "item1 and item2 have the same script path")
	assert_true(item1.__packedScenePath == item2.__packedScenePath, "item1 and item2 have the same scene path")
	
func teardown():
	item1.free()
	item2.free()
	