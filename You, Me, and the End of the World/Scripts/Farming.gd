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
	pass
