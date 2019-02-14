extends Node2D

onready var player1 = get_node("TileMap/FarmingPlayer1")
onready var player2 = get_node("TileMap/FarmingPlayer2")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func getClosestTool(player):
	if player == 1:
		if player1.position.x < 270 or player1.position.x > 760 or player1.position.y > 160:
			return "none"
		#elif position closest to seedbag
		#elif position closest to watering can
		#elif position closest to basket
		else: #closest to hoe
			return "hoe"
	else: #if player == 2:
		if player2.position.x < 270 or player2.position.x > 760 or player2.position.y > 160:
			return "none"
		#elif position closest to seedbag
		#elif position closest to watering can
		#elif position closest to basket
		else: #closest to hoe
			return "hoe"
			
func isCloseToBench(player):
	if player == 1:
		if player1.position.x < 270 or player1.position.x > 760 or player1.position.y > 160:
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

func _process(delta):
	#player 1 wants to pick up or swap tools
	if Input.is_action_just_pressed("p1_action2"):
		#check if the player is close enough to any tools to do this
		var closestTool = getClosestTool(1)
		if closestTool == "hoe":
			if player1.heldItem == "hoe" and isCloseToBench(1):
				get_node("ToolBench/hoe").unEquip()
				player1.heldItem = "none"
			else:
				get_node("ToolBench/hoe").equip(1)
				player1.heldItem = "hoe"
	if Input.is_action_just_pressed("p1_action1"):
		#TODO: add cooldown
		if player1.heldItem == "hoe":
			hoeAction()
	pass
