extends Node2D

var crosshair = load("res://Images/Crosshair.png")
#export (NodePath) var button_path
onready var surrenderButton = get_node("CombatHUD/Surrender Button")
onready var runButton = get_node("CombatHUD/Run Away Button")
onready var enemyHealth = get_node("TileMap/Enemy").totalHealth
onready var playerHealth = get_node("TileMap/CombatPlayer").totalHealth
onready var defeatedDialog = get_node("DefeatedDialog")
onready var player = get_node("TileMap/CombatPlayer")
onready var player2 = get_node("TileMap/CombatPlayer2")
onready var enemy = get_node("TileMap/Enemy")
var currentPlayer = 1

func _ready():
	#freeze player 2 to make player 1 the active player
	player2.freeze()
	player.unfreeze()
	#set mouse cursor to combat crosshairs
	Input.set_custom_mouse_cursor(crosshair, 0, Vector2(15, 15))
	#connect button signals
	self.get_node("Camera").make_current()
	surrenderButton.connect("pressed",self, "on_surrender_pressed")
	runButton.connect("pressed",self, "on_run_pressed")

#checks to see if the player surrenders successfully upon pressing the surrender button.
#this depends on the enemy's AI, but is also subject to random chance
func on_surrender_pressed():
	var mercy = get_node("/root/Combat/TileMap/Enemy").get("mercy") #number of chances on the surrender check
	var chance = 0 #value randomly generated for the check
	var minChance = 0.5 #minimum value needed to pass check #TODO: balance this
	if mercy > 0:
		for i in range (mercy):
			chance = rand_range(0,1)
			print(str(chance))
			if chance > minChance: #check passed, player surrenders
				print("I accept your surrender")
				get_tree().change_scene("res://tscn files/World1.tscn")
				#TODO: check how greedy the enemy is, check the players' inventories, and transfer appropriate items
				#TODO: check how spiteful the enemy is to see how badly the enemy maims the player and whether or not they kill them
				#TODO: apply appropriate maim damage
				#TODO: apply damage from combat into main scene
	#TODO: disable surrender button. (if the code gets here, the check has been failed)
	print("surrender failed")
	#TODO:
	#check how badly the enemy robs the player
	#check how badly the enemy maims the player and whether or not they kill them
	print("Uncle, uncle, uncle")
	
func on_run_pressed():
	var runChance = rand_range(0,1) #the player's value to try and run away
	var runStop = get_node("/root/Combat/TileMap/Enemy").get("runStopVal") #the value to beat to successfully run away
	if runChance > runStop: #run away successful
		if (runChance - runStop) > 0.2: #scott free escape
			print("Ruuuun, Forrest, ruuuun")
		else: #damaged escape
			print("You had your tail between your legs and you tripped on it")
			#TODO: see how bad the damage is and apply it
		get_tree().change_scene("res://tscn files/World1.tscn")
	else: #run away failed
		print("You froze in fear!")
		#TODO: apply a cooldown before another run away can be attempted
		#maybe deplete the player's stamina?
		
func tagTeam():
	print("Whose music is that?")
	#check how many tag teams are remaining (maybe let the players have 2?)
	#play a tag team animation
	#switch the player controls and the active player
	switchPlayer()
	#switch player sprites
	#switch player weapons
	#switch player health
	#make the player temporarily 
	#print("He hits him with the chair!")
		
func on_enemy_defeated():
	print("victory")
	defeatedDialog.show()
	defeatedDialog.winner("player")
	#get_tree().change_scene("res://tscn files/World1.tscn")

func on_player_defeated():
	print("defeat")
	defeatedDialog.show()
	defeatedDialog.winner("enemy")

func _pause():
	print("Game paused")
	get_tree().paused = true
	#$pause_popup.update()
	$pause_popup.show()
	
func switchPlayer():
	if currentPlayer == 1:
		currentPlayer = 2
		player.freeze()
		player2.unfreeze()
	else:
		currentPlayer = 1
		player2.freeze()
		player.unfreeze()
	
func _process(delta):
	enemyHealth = get_node("TileMap/Enemy").totalHealth
	playerHealth = get_node("TileMap/CombatPlayer").totalHealth
	if player.position.x > enemy.position.x:
		player.updateFacingRight(false)
		get_node("TileMap/CombatPlayer/Sword").updateFacingRight(false)
	elif player.position.x < enemy.position.x:
		player.updateFacingRight(true)
		get_node("TileMap/CombatPlayer/Sword").updateFacingRight(true)
	if Input.is_action_just_pressed("p1_action1"):
		if player.position.x < get_node("TileMap/TagTeamCheck").position.x:
			tagTeam()
	if Input.is_action_pressed("pause"):
		_pause()
	if playerHealth <= 0: #got rekt
		on_player_defeated()
	elif enemyHealth <= 0: #enemy is dead
		on_enemy_defeated()

func _on_Border_mouse_entered():
	pass # replace with function body
