extends KinematicBody2D

onready var equippedPlayer = 0 #0 means not equipped, 1 is player 1, 2 is player 2
onready var isFacingRight = true
var actionKey
var sprite
onready var player1 = get_node("TileMap/FarmingPlayer1")
onready var player2 = get_node("TileMap/FarmingPlayer2")
onready var toolBench = get_node("ToolBench")
var toolBenchX = 0 #adjust these depending on which tool this is
var toolBenchY = 0
	
func updateFacingRight(boolean):
	isFacingRight = boolean
	if isFacingRight:
		if sprite != null:
			sprite.set_flip_h(false)
	else: #facing left
		if sprite != null:
			sprite.set_flip_h(true)
			
func equip(player):
	equippedPlayer = player
	if equippedPlayer == 1:
		actionKey = is_action_just_pressed("p1_action1")
	elif equippedPlayer == 2:
		actionKey = is_action_just_pressed("p2_action1")
	
func unEquip():
	equippedPlayer = 0
	
func _process():
	if equippedPlayer == 1: #follow player 1
		position.y = player1.position.y
		if isFacingRight:
			position.x = player1.position.x + 20
		else:
			position.x = player1.position.x - 20
	elif equippedPlayer == 2: #follow player 2
		position.y = player2.position.y
		if isFacingRight:
			position.x = player2.position.x + 20
		else:
			position.x = player2.position.x - 20
	else: #go to position on the tool bench
		position.x = toolBench.position.x + toolBenchX
		position.y = toolBench.position.y + toolBenchY
	pass