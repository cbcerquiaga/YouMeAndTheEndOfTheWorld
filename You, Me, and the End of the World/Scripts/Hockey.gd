extends Node2D

onready var camera = get_node("playerTracker/Camera2D")
onready var clock = get_node("Clock")
onready var timeLabel = get_node("HUD/timeLeftLabel")
onready var periodLabel = get_node("HUD/periodLabel")
onready var homeScoreLabel = get_node("HUD/homeScoreLabel")
onready var awayScoreLabel = get_node("HUD/awayScoreLabel")
var period
var playerTeamScore
var oppTeamScore
var playerTeamSubs
var oppTeamSubs
onready var arena = "pond"
onready var homeTeam = "player"
onready var gameStarted = false
onready var playerTeamGoalie = get_node("boards/playerTeam/goalie")
onready var oppTeamGoalie = get_node("boards/AITeam/goalie")
onready var puck = get_node("boards/puck")
onready var leftGoal = get_node("boards/goal 1")
onready var rightGoal = get_node("boards/goal 2")
onready var inPlay = get_node("boards/in play")
#onready var oppTeamGoalie = get_node("boards/oppTeam/goalie")

func _ready():
	camera.make_current()
	period = 1
	periodLabel.text = str(period)
	playerTeamScore = 0
	oppTeamScore = 0
	if homeTeam == "player": #home team always goes left to right in the 1st
		homeScoreLabel.text = str(playerTeamScore)
		awayScoreLabel.text = str(oppTeamScore)
	else:
		homeScoreLabel.text = str(oppTeamScore)
		awayScoreLabel.text = str(playerTeamScore)
	playerTeamSubs = [9,12,36]
	oppTeamSubs = [6,8,50]
	pass
	
func _pause():
	print("Game paused")
	get_tree().paused = true
	#$pause_popup.update()
	$pause_popup.show()

func _process(delta):
	timeLabel.text = str(clock.wait_time)
	if Input.is_action_pressed("pause"):
		_pause()
	#do initial countdown
	#start the game
	if !gameStarted:
		pickPlayers()
		startGame()
		gameStarted = true
	elif !inPlay.overlaps_body(puck):
		print("please, sir, may we have our puck?")
		faceoff()
	else:
		#check if the puck went in a net
		if leftGoal.overlaps_body(puck):
			if homeTeam == "player":
				if period % 2 == 0:#player goal
					playerTeamScore = playerTeamScore + 1
					homeScoreLabel.text = str(playerTeamScore)
				else:#ai goal
					oppTeamScore = oppTeamScore + 1
					awayScoreLabel.text = str(oppTeamScore)
			else:#homeTeam == "ai"
				if period % 2 == 0:#ai goal
					oppTeamScore = oppTeamScore + 1
					homeScoreLabel.text = str(oppTeamScore)
				else:
					playerTeamScore = playerTeamScore + 1
					awayScoreLabel.text = str(playerTeamScore)
			faceoff()
		elif rightGoal.overlaps_body(puck):
			if homeTeam == "player":
				if period % 2 == 1:#player goal
					playerTeamScore = playerTeamScore + 1
					homeScoreLabel.text = str(playerTeamScore)
				else:#ai goal
					oppTeamScore = oppTeamScore + 1
					awayScoreLabel.text = str(oppTeamScore)
			else:#hoeTeam == "ai"
				if period % 2 == 1:#ai goal
					oppTeamScore = oppTeamScore + 1
					homeScoreLabel.text = str(oppTeamScore)
				else:
					playerTeamScore = playerTeamScore + 1
					awayScoreLabel.text = str(playerTeamScore)
			faceoff()
		#check for a fight
		#make the goalies track the puck
		playerTeamGoalie.setPuckPosition(get_node("boards/puck").position)
		oppTeamGoalie.setPuckPosition(get_node("boards/puck").position)
		if clock.time_left == 0: #period over
			clock.stop()
			if period < 3:
				period+= 1
				newPeriod()
			else:
				if playerTeamScore > oppTeamScore:
					print("the players' team won! Yay!")
				elif oppTeamScore > playerTeamScore:
					print("oh no! The players lost!")
				
	pass
	
func startGame():
	lineUpPlayers()
	clock.start()

func newPeriod():
	clock.wait_time = 120
	periodLabel.text = str(period)
	pickPlayers()
	lineUpPlayers()
	clock.start()
	
func faceoff():
	clock.stop()
	lineUpPlayers()
	#countdown
	clock.start()
	
#line up the players and goalies for the start of a period or after a goal
func lineUpPlayers():
	if period % 2 == 0: #period 2 or OT
		#put Ap1 on the top left
		#put Ap2 on the bottom left
		#put Hp1 on the bottom right
		#put Hp2 on the top right
		#put Agoalie on the left
		#put Hgoalie on the right
		print("the long change")
	else:
		#put Ap1 on the bottom right
		#put Ap2 on the top right
		#put Hp1 on the top left
		#put Hp2 on the bottom left
		#put Agoalie on the right
		oppTeamGoalie.position.x = 1800
		oppTeamGoalie.position.y = 920
		oppTeamGoalie.facingRight = false
		#put Hgoalie on the left
		print("the announcers never say the short change for some reason")
		
func pickPlayers():
	#pause players so they can't move
	#show pick players popup
		#there are 2 chosen player slots and 3 bench player slots
		#clicking on a player highlights them
		#clicking on another player swaps them
		#players who lost a fight cannot be selected if they're in a bench slot and have a lock over them
		#if there is a player who lost a fight in a chosen slot, grey out the OK button
		#else let the button get clicked and start the game
		#make an array with the 2 players who were chosen
		var chosenPlayer1 = 8
		var chosenPlayer2 = 19
		#assign the players their bodies and attributes
		substitutePlayers(chosenPlayer1, chosenPlayer2)

func substitutePlayers(p1, p2):
	#assign p1 their body
	#assign p1 their attributes
	#assign p2 their body
	#assign p2 their attributes
	print(str(p1) + " and " + str(p2) + " the dynamic duo")
	