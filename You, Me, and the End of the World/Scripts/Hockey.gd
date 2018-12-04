extends Node2D

onready var camera = get_node("playerTracker/Camera2D")
onready var clock = get_node("Clock")
var period
var playerTeamScore
var oppTeamScore
var playerTeamSubs
var oppTeamSubs
onready var arena = "pond"
onready var gameStarted = false

func _ready():
	camera.make_current()
	period = 1
	playerTeamScore = 0
	oppTeamScore = 0
	playerTeamSubs = [9,12,36]
	oppTeamSubs = [6,8,50]
	pass

func _process(delta):
	#do initial countdown
	#start the game
	if !gameStarted:
		pickPlayers()
		startGame()
		gameStarted = true
	else:
		#check if the puck went in a net
		#check for a fight
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
	pickPlayers()
	lineUpPlayers()
	clock.start()
	
#line up the players and goalies for the start of a period or after a goal
func lineUpPlayers():
	if period % 2 == 0: #period 2 or OT
		#put Ap1 on the bottom right
		#put Ap2 on the top right
		#put Hp1 on the top left
		#put Hp2 on the bottom left
		#put Agoalie on the right
		#put Hgoalie on the left
		print("the long change")
	else:
		#put Ap1 on the top left
		#put Ap2 on the bottom left
		#put Hp1 on the bottom right
		#put Hp2 on the top right
		#put Agoalie on the left
		#put Hgoalie on the right
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
		var chosenPlayer1 = 3
		var chosenPlayer2 = 19
		#assign the players their bodies and attributes
		substitutePlayers(chosenPlayer1, chosenPlayer2)

func substitutePlayers(p1, p2):
	#assign p1 their body
	#assign p1 their attributes
	#assign p2 their body
	#assign p2 their attributes
	print(str(p1) + " and " + str(p2) + " the dynamic duo")
	