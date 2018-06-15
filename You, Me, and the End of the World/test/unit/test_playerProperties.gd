extends "res://addons/gut/test.gd"

var playerProperty1 = preload('res://Scripts/playerProperties.gd').new()

func setup():
	pass

func teardown():
	pass

func test_Adding_Item():
	assert_true(playerProperty1.getSpeed() == 200, "The default speed should be 200 for the player")
