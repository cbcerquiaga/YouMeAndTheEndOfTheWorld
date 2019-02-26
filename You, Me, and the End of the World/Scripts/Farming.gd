extends Node2D

onready var player1 = get_node("TileMap/FarmingPlayer1")
onready var player2 = get_node("TileMap/FarmingPlayer2")
onready var plantSeed = load("res://tscn files/Seed.tscn")
onready var waterDrop = load("res://tscn files/WaterDrop.tscn")
var seeds
var drops
var savedHarvest
var activeHarvest

func _ready():
	seeds = [] #stores the seeds so they can be looped through
	drops = []#just like seeds but for water droplets
	savedHarvest = 0
	activeHarvest = 0
	pass
	
func getClosestTool(player):
	if player == 1:
		if !isCloseToBench(1):
			return "none"
		elif player1.position.x > 405 and player1.position.x < 480: #position closest to seedbag
			return "seedBag"
		elif player1.position.x >= 480: #position closest to watering can
			return "wateringCan"
		#elif position closest to basket
		else: #closest to hoe
			return "hoe"
	else: #if player == 2:
		if !isCloseToBench(2):
			return "none"
		elif player2.position.x > 405 and player2.position.x < 480: #position closest to seedbag
			return "seedBag"
		elif player2.position.x >= 480: #position closest to watering can
			return "wateringCan"
		#elif position closest to basket
		else: #closest to hoe
			return "hoe"
			
func isCloseToBench(player):
	if player == 1:
		if player1.position.x < 270 or player1.position.x > 760 or player1.position.y > 160:
			#print("far from the bench")
			return false
		else:
			return true
	else: #player == 2:
		if player2.position.x < 270 or player2.position.x > 760 or player2.position.y > 160:
			return false
		else:
			return true
			
func hoeAction():
	var hoePos = get_node("ToolBench/hoe").position
	#print(str(hoePos))
	var affectedArray = [] #TODO: add overlap so multiple plots can be farmed at once
	if hoePos.x > 255 and hoePos.x < 780: #in-bounds x-wise, trying to save the computer from having to do all these conditionals if it doesn't have to
		if hoePos.y > 231.6 and hoePos.y < 306.6: #first row
			if hoePos.x < 330:
				affectedArray.append("1-1")
				#print(str(affectedArray))
			elif hoePos.x < 405:
				affectedArray.append("2-1")
			elif hoePos.x < 480:
				affectedArray.append("3-1")
			elif hoePos.x < 555:
				affectedArray.append("4-1")
			elif hoePos.x < 630:
				affectedArray.append("5-1")
			elif hoePos.x < 705:
				affectedArray.append("6-1")
			else: #if hoePos.x < 780:
				affectedArray.append("7-1")
		elif hoePos.y > 306.6 and hoePos.y < 381.6: #second row
			if hoePos.x < 330:
				affectedArray.append("1-2")
				#print(str(affectedArray))
			elif hoePos.x < 405:
				affectedArray.append("2-2")
			elif hoePos.x < 480:
				affectedArray.append("3-2")
			elif hoePos.x < 555:
				affectedArray.append("4-2")
			elif hoePos.x < 630:
				affectedArray.append("5-2")
			elif hoePos.x < 705:
				affectedArray.append("6-2")
			else: #if hoePos.x < 780:
				affectedArray.append("7-2")
		elif hoePos.y > 381.6 and hoePos.y < 456.6: #third row
			if hoePos.x < 330:
				affectedArray.append("1-3")
				#print(str(affectedArray))
			elif hoePos.x < 405:
				affectedArray.append("2-3")
			elif hoePos.x < 480:
				affectedArray.append("3-3")
			elif hoePos.x < 555:
				affectedArray.append("4-3")
			elif hoePos.x < 630:
				affectedArray.append("5-3")
			elif hoePos.x < 705:
				affectedArray.append("6-3")
			else: #if hoePos.x < 780:
				affectedArray.append("7-3")
		elif hoePos.y > 456.6 and hoePos.y < 531.6: #fourth row
			if hoePos.x < 330:
				affectedArray.append("1-4")
				#print(str(affectedArray))
			elif hoePos.x < 405:
				affectedArray.append("2-4")
			elif hoePos.x < 480:
				affectedArray.append("3-4")
			elif hoePos.x < 555:
				affectedArray.append("4-4")
			elif hoePos.x < 630:
				affectedArray.append("5-4")
			elif hoePos.x < 705:
				affectedArray.append("6-4")
			else: #if hoePos.x < 780:
				affectedArray.append("7-4")
	hoeTheLand(affectedArray)
		
func hoeTheLand(affectedArray):
	#print(str(affectedArray))
	if affectedArray.has("1-1"):
		get_node("TileMap/plots/plot1-1").hoe()
	elif affectedArray.has("2-1"):
		get_node("TileMap/plots/plot2-1").hoe()
	elif affectedArray.has("3-1"):
		get_node("TileMap/plots/plot3-1").hoe()
	elif affectedArray.has("4-1"):
		get_node("TileMap/plots/plot4-1").hoe()
	elif affectedArray.has("5-1"):
		get_node("TileMap/plots/plot5-1").hoe()
	elif affectedArray.has("6-1"):
		get_node("TileMap/plots/plot6-1").hoe()
	elif affectedArray.has("7-1"):
		get_node("TileMap/plots/plot7-1").hoe()
	elif affectedArray.has("1-2"):
		get_node("TileMap/plots/plot1-2").hoe()
	elif affectedArray.has("2-2"):
		get_node("TileMap/plots/plot2-2").hoe()
	elif affectedArray.has("3-2"):
		get_node("TileMap/plots/plot3-2").hoe()
	elif affectedArray.has("4-2"):
		get_node("TileMap/plots/plot4-2").hoe()
	elif affectedArray.has("5-2"):
		get_node("TileMap/plots/plot5-2").hoe()
	elif affectedArray.has("6-2"):
		get_node("TileMap/plots/plot6-2").hoe()
	elif affectedArray.has("7-2"):
		get_node("TileMap/plots/plot7-2").hoe()
	elif affectedArray.has("1-3"):
		get_node("TileMap/plots/plot1-3").hoe()
	elif affectedArray.has("2-3"):
		get_node("TileMap/plots/plot2-3").hoe()
	elif affectedArray.has("3-3"):
		get_node("TileMap/plots/plot3-3").hoe()
	elif affectedArray.has("4-3"):
		get_node("TileMap/plots/plot4-3").hoe()
	elif affectedArray.has("5-3"):
		get_node("TileMap/plots/plot5-3").hoe()
	elif affectedArray.has("6-3"):
		get_node("TileMap/plots/plot6-3").hoe()
	elif affectedArray.has("7-3"):
		get_node("TileMap/plots/plot7-3").hoe()
	elif affectedArray.has("1-4"):
		get_node("TileMap/plots/plot1-4").hoe()
	elif affectedArray.has("2-4"):
		get_node("TileMap/plots/plot2-4").hoe()
	elif affectedArray.has("3-4"):
		get_node("TileMap/plots/plot3-4").hoe()
	elif affectedArray.has("4-4"):
		get_node("TileMap/plots/plot4-4").hoe()
	elif affectedArray.has("5-4"):
		get_node("TileMap/plots/plot5-4").hoe()
	elif affectedArray.has("6-4"):
		get_node("TileMap/plots/plot6-4").hoe()
	elif affectedArray.has("7-4"):
		get_node("TileMap/plots/plot7-4").hoe()
		
func plantSeed(plot):
	#print("plot = " + str(plot))
	if plot == "1-1":
		get_node("TileMap/plots/plot1-1").plant()
	elif plot == "2-1":
		get_node("TileMap/plots/plot2-1").plant()
	elif plot == "3-1":
		get_node("TileMap/plots/plot3-1").plant()
	elif plot == "4-1":
		get_node("TileMap/plots/plot4-1").plant()
	elif plot == "5-1":
		get_node("TileMap/plots/plot5-1").plant()
	elif plot == "6-1":
		get_node("TileMap/plots/plot6-1").plant()
	elif plot == "7-1":
		get_node("TileMap/plots/plot7-1").plant()
	elif plot == "1-2":
		get_node("TileMap/plots/plot1-2").plant()
	elif plot == "2-2":
		get_node("TileMap/plots/plot2-2").plant()
	elif plot == "3-2":
		get_node("TileMap/plots/plot3-2").plant()
	elif plot == "4-2":
		get_node("TileMap/plots/plot4-2").plant()
	elif plot == "5-2":
		get_node("TileMap/plots/plot5-2").plant()
	elif plot == "6-2":
		get_node("TileMap/plots/plot6-2").plant()
	elif plot == "7-2":
		get_node("TileMap/plots/plot7-2").plant()
	elif plot == "1-3":
		get_node("TileMap/plots/plot1-3").plant()
	elif plot == "2-3":
		get_node("TileMap/plots/plot2-3").plant()
	elif plot == "3-3":
		get_node("TileMap/plots/plot3-3").plant()
	elif plot == "4-3":
		get_node("TileMap/plots/plot4-3").plant()
	elif plot == "5-3":
		get_node("TileMap/plots/plot5-3").plant()
	elif plot == "6-3":
		get_node("TileMap/plots/plot6-3").plant()
	elif plot == "7-3":
		get_node("TileMap/plots/plot7-3").plant()
	elif plot == "1-4":
		get_node("TileMap/plots/plot1-4").plant()
	elif plot == "2-4":
		get_node("TileMap/plots/plot2-4").plant()
	elif plot == "3-4":
		get_node("TileMap/plots/plot3-4").plant()
	elif plot == "4-4":
		get_node("TileMap/plots/plot4-4").plant()
	elif plot == "5-4":
		get_node("TileMap/plots/plot5-4").plant()
	elif plot == "6-4":
		get_node("TileMap/plots/plot6-4").plant()
	elif plot == "7-4":
		get_node("TileMap/plots/plot7-4").plant()
		
func seedBagAction(player):
	if player == 1:
		create_seeds(player1.get_global_position(), player1.lastDirection)
	elif player == 2:
		create_seeds(player2.get_global_position(), player2.lastDirection)
		
func create_seeds(position, direction):
	#print("create seeds in the direction of " + str(direction))
	if direction == "left":
		#emitSeed("S", position)
		emitSeed("SW", position)
		emitSeed("W", position)
		emitSeed("NW", position)
		#emitSeed("N", position)
	elif direction == "right":
		#emitSeed("S", position)
		emitSeed("SE", position)
		emitSeed("E", position)
		emitSeed("NE", position)
		#emitSeed("N", position)
	elif direction == "up":
		#emitSeed("W", position)
		emitSeed("NW", position)
		emitSeed("N", position)
		emitSeed("NE", position)
		#emitSeed("E", position)
	elif direction == "down":
		#emitSeed("W", position)
		emitSeed("SW", position)
		emitSeed("S", position)
		emitSeed("SE", position)
		#emitSeed("E", position)
		
func emitSeed(direction, position):
	#print("emit that seed! " + str(direction) + str(position))
	var tempSeed = plantSeed.instance()
	tempSeed.position = position
	get_node("ToolBench").add_child(tempSeed)
	seeds.append(tempSeed)
	if direction == "N":
		tempSeed.motion = Vector2(0,-2)
	elif direction == "NW":
		tempSeed.motion = Vector2(-1,-1)
	elif direction == "W":
		tempSeed.motion = Vector2(-2,0)
	elif direction == "SW":
		tempSeed.motion = Vector2(-1,1)
	elif direction == "S":
		tempSeed.motion = Vector2(0,2)
	elif direction == "SE":
		tempSeed.motion = Vector2(1,1)
	elif direction == "E":
		tempSeed.motion = Vector2(2,0)
	else: #if direction == "NE":
		tempSeed.motion = Vector2(1,-1)
	#print("tempSeed: " + str(direction) +  " location: " + str(tempSeed.position) + " motion: " + str(tempSeed.motion))
	
func wateringCanAction(player):
	#print("squirt squirt")
	if player == 1:
		create_waterDrops(player1.get_global_position(), player1.lastDirection)
	elif player == 2:
		create_waterDrops(player2.get_global_position(), player2.lastDirection)
		

func create_waterDrops(position, direction):
	if direction == "left":
		emitDrop("SW", position)
		emitDrop("W", position)
		emitDrop("NW", position)
	elif direction == "right":
		emitDrop("SE", position)
		emitDrop("E", position)
		emitDrop("NE", position)
	elif direction == "up":
		emitDrop("NW", position)
		emitDrop("N", position)
		emitDrop("NE", position)
	elif direction == "down":
		emitDrop("SW", position)
		emitDrop("S", position)
		emitDrop("SE", position)
		
func emitDrop(direction,position):
	var tempDrop = waterDrop.instance()
	tempDrop.position = position
	get_node("ToolBench").add_child(tempDrop)
	drops.append(tempDrop)
	if direction == "N":
		tempDrop.motion = Vector2(0,-2)
	elif direction == "NW":
		tempDrop.motion = Vector2(-1,-1)
	elif direction == "W":
		tempDrop.motion = Vector2(-2,0)
	elif direction == "SW":
		tempDrop.motion = Vector2(-1,1)
	elif direction == "S":
		tempDrop.motion = Vector2(0,2)
	elif direction == "SE":
		tempDrop.motion = Vector2(1,1)
	elif direction == "E":
		tempDrop.motion = Vector2(2,0)
	else: #if direction == "NE":
		tempDrop.motion = Vector2(1,-1)
		
func waterPlant(plot):
	print("plot = " + str(plot))
	if plot == "1-1":
		get_node("TileMap/plots/plot1-1").water()
	elif plot == "2-1":
		get_node("TileMap/plots/plot2-1").water()
	elif plot == "3-1":
		get_node("TileMap/plots/plot3-1").water()
	elif plot == "4-1":
		get_node("TileMap/plots/plot4-1").water()
	elif plot == "5-1":
		get_node("TileMap/plots/plot5-1").water()
	elif plot == "6-1":
		get_node("TileMap/plots/plot6-1").water()
	elif plot == "7-1":
		get_node("TileMap/plots/plot7-1").water()
	elif plot == "1-2":
		get_node("TileMap/plots/plot1-2").water()
	elif plot == "2-2":
		get_node("TileMap/plots/plot2-2").water()
	elif plot == "3-2":
		get_node("TileMap/plots/plot3-2").water()
	elif plot == "4-2":
		get_node("TileMap/plots/plot4-2").water()
	elif plot == "5-2":
		get_node("TileMap/plots/plot5-2").water()
	elif plot == "6-2":
		get_node("TileMap/plots/plot6-2").water()
	elif plot == "7-2":
		get_node("TileMap/plots/plot7-2").water()
	elif plot == "1-3":
		get_node("TileMap/plots/plot1-3").water()
	elif plot == "2-3":
		get_node("TileMap/plots/plot2-3").water()
	elif plot == "3-3":
		get_node("TileMap/plots/plot3-3").water()
	elif plot == "4-3":
		get_node("TileMap/plots/plot4-3").water()
	elif plot == "5-3":
		get_node("TileMap/plots/plot5-3").water()
	elif plot == "6-3":
		get_node("TileMap/plots/plot6-3").water()
	elif plot == "7-3":
		get_node("TileMap/plots/plot7-3").water()
	elif plot == "1-4":
		get_node("TileMap/plots/plot1-4").water()
	elif plot == "2-4":
		get_node("TileMap/plots/plot2-4").water()
	elif plot == "3-4":
		get_node("TileMap/plots/plot3-4").water()
	elif plot == "4-4":
		get_node("TileMap/plots/plot4-4").water()
	elif plot == "5-4":
		get_node("TileMap/plots/plot5-4").water()
	elif plot == "6-4":
		get_node("TileMap/plots/plot6-4").water()
	elif plot == "7-4":
		get_node("TileMap/plots/plot7-4").water()


func _process(delta):
	if seeds.size() > 0: #there are seeds in the field
		for i in seeds:
			if i.affectedPlot != "0-0":#affectedPlot is something othr than its default
				plantSeed(i.affectedPlot)
				seeds.remove(seeds.find(i))
				i.queue_free()
			elif i.remainingTime < -5: #the time remaining when the plot would be affected
				seeds.remove(seeds.find(i))
				i.queue_free()
	if drops.size() > 0: #there are droplets in the field
		for i in drops:
			if i.affectedPlot != "0-0":#affectedPlot is something othr than its default
				waterPlant(i.affectedPlot)
				drops.remove(drops.find(i))
				i.queue_free()
			elif i.remainingTime < -5: #the time remaining when the plot would be affected
				drops.remove(drops.find(i))
				i.queue_free()
	#player 1 wants to pick up or swap tools
	if Input.is_action_just_pressed("p1_action2"):
		var closestTool = getClosestTool(1)
		#check if the player is close enough to any tools to do this
		if closestTool == "hoe":
			if player1.heldItem == "hoe" and isCloseToBench(1):
				get_node("ToolBench/hoe").unEquip()
				player1.heldItem = "none"
			else:
				get_node("ToolBench/seedBag").unEquip()
				get_node("ToolBench/hoe").equip(1)
				get_node("ToolBench/wateringCan").unEquip()
				player1.heldItem = "hoe"
		elif closestTool == "seedBag":
			if player1.heldItem == "seedBag" and isCloseToBench(1):
				get_node("ToolBench/seedBag").unEquip()
				player1.heldItem = "none"
			else:
				get_node("ToolBench/hoe").unEquip()
				get_node("ToolBench/seedBag").equip(1)
				get_node("ToolBench/wateringCan").unEquip()
				player1.heldItem = "seedBag"
		elif closestTool == "wateringCan":
			if player1.heldItem == "wateringCan" and isCloseToBench(1):
				get_node("ToolBench/wateringCan").unEquip()
				player1.heldItem = "none"
			else:
				get_node("ToolBench/hoe").unEquip()
				get_node("ToolBench/seedBag").unEquip()
				get_node("ToolBench/wateringCan").equip(1)
				player1.heldItem = "wateringCan"
	if Input.is_action_just_pressed("p1_action1"):
		#TODO: add cooldown
		if player1.heldItem == "hoe":
			hoeAction()
		if player1.heldItem == "seedBag":
			seedBagAction(1)
		if player1.heldItem == "wateringCan":
			wateringCanAction(1)
	pass
