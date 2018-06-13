extends Node

#Initializing
var __itemName = 'Unknown'
var __worth = 0
var __packedScenePath = ""
var __scriptPath = ""

func __init__(itemName, worth, scenePath, scriptPath):
	self.__itemName = itemName
	self.__worth = worth
	self.__packedScenePath = scenePath
	self.__scriptPath = scriptPath

#Fuctions
#This is the function called when the player picks up the item
#First we try to add the item to the player's inventory
#Then we hide the item from the scene, but it is still there and inactive
#TODO If we free the item this will not allow the player to drop it later, could be done better?
func handle_item_pickup(player):
	if(player.has_method('addItem')):
		player.addItem(self)
		self.set_collision_mask_bit(1, false)
		self.set_collision_layer_bit(1, false)
		self.hide()

#Getters and Setters
func getName():
	return self.__itemName
	
func getWorth():
	return self.__worth
	
func getScriptPath():
	return self.__scriptPath

func getScenePath():
	return self.__packedScenePath