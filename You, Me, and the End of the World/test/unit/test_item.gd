extends "res://addons/gut/test.gd"

var item1
var item2
var player

func setup():
	item1 = load("res://Scripts/item.gd").new()
	item2 = load("res://Scripts/item.gd").new()
	player = load("res://Scripts/player1.gd").new()
	item1.__init__('Coin', "misc", 1, 0, 5, 'res://tscn files/coins.tscn', 'res://Scripts/coins.gd', "res://Images/iur-2.png", "A Quarter")
	item2.__init__("coins", "misc", 42, 0, 5, "", "", "", "Quarters")

func test_equality():
	assert_true(item1.itemName != item2.itemName, "Error [1] item1 and item2 do not have the same name")
	assert_true(item1.itemType == item2.itemType, "Error [2] item1 and item2 do not have the same type")
	assert_true(item1.worth != item2.worth, "Error [3] item1 and item2 do not have the same worth")
	assert_true(item1.scriptPath != item2.scriptPath, "Error [4] item1 and item2 have the same script path")
	assert_true(item1.packedScenePath != item2.packedScenePath, "Error [5] item1 and item2 have the same scene path")
	

func test_pickup():
	assert_true(item1.get_collision_layer_bit(1) == true, "Error [6] item1 collision layer bit 1 is not on before pickup")
	assert_true(item1.get_collision_mask_bit(1) == true, "Error [7] item1 collision mask bit 1 is not on before pickup")
	assert_true(item1.pickedUp == false, "Error [8] item1 has been recorded as picked up before it was picked up")
	
	item1.handle_item_pickup(player)
	
	assert_true(item1.get_collision_layer_bit(1) == false, "Error [9] item1 collision layer bit was not changed after pickup")
	assert_true(item1.get_collision_mask_bit(1) == false, "Error [10] item1 collision mask bit was not changed after pickup")
	assert_true(item1.pickedUp == true, "Error [11] item1's instance variable pickedUp was not changed after pickup")
	
	item1.handle_item_pickup(player)
	
	assert_true(item1.pickedUp == true, "Error [12] item1's instance variable pickedUp was changed after it was pickedUp twice (not possible)")
	assert_true(item1.get_collision_layer_bit(1) == false, "Error [13] item1's collision layer was changed after being picked up twice")
	assert_true(item1.get_collision_mask_bit(1) == false, "Error [14] items1's collision mask was changed after being picked up twice")

func test_worth():
	assert_true(item1.worth == 1, "Error [15] Set worth for item1 is not correct")
	assert_true(item2.worth == 42, "Error [16] Set worth for item2 is not correct")
	

func teardown():
	item1.free()
	item2.free()
	