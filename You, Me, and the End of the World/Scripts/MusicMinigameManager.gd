extends Node

#these keep track of the current and next key presses for each player
var tempo = 100 #time between note spawns
var time #tracks time for tempo
var song1 #the actual song being played for player 1
var song2 #song for player 2
var currentNote1 = 0 #index in the song where p1 is now
var currentNote2 = 0 #index for player 2
#var loops = 2 #number of times we loop through the song before completion
var defaultSong = ["L","C","L","R","C","R"] #default song if song isn't changed
var p1Score = 0
var p1streak = 0 #the number of successful catches in a row for player 1
var p2Score = 0
var p2streak = 0 #the number of successful catches in a row for player 2
onready var p1Pos = "L"
onready var p2Pos = "C"
onready var note = load("res://tscn files/MusicKey.tscn")
onready var player1 = get_node("player1")
onready var player2 = get_node("player2")
var notes #array of all notes
#HUD elements
onready var scoreLabel1 = get_node("HUD/p1ScoreLabel")
onready var scoreLabel2 = get_node("HUD/p2ScoreLabel2")

func _ready():
	time = 0
	song1 = defaultSong
	song2 = ["L", "L", "L", "R", "R", "R", "L", "R"]
	notes = []
	pass

func _pause():
	print("Game paused")
	get_tree().paused = true
	#$pause_popup.update()
	$pause_popup.show()
	
func p1Left():
	if p1Pos == "C":
		p1Pos = "L"
		player1.position.x = 630
	elif p1Pos == "R":
		p1Pos = "C"
		player1.position.x = 730
		
func p2Left():
	if p2Pos == "C":
		p2Pos = "L"
		player2.position.x = 110
	elif p2Pos == "R":
		p2Pos = "C"
		player2.position.x = 210
		
func p1Right():
	if p1Pos == "C":
		p1Pos = "R"
		player1.position.x = 830
	elif p1Pos == "L":
		p1Pos = "C"
		player1.position.x = 730
		
func p2Right():
	if p2Pos == "C":
		p2Pos = "R"
		player2.position.x = 310
	elif p2Pos == "L":
		p2Pos = "C"
		player2.position.x = 210
	
func initNote1(spawnPos):
	#print("initialize it, do it now! " + str(spawnPos))
	var tempNote = note.instance()
	tempNote.position = spawnPos
	get_node("noteEmitter").add_child(tempNote)
	notes.append(tempNote)
	pass
	
func spawnNoteAtSide1(side):
	var spawnPos = Vector2()
	spawnPos.y = 50
	if side == "L":
		spawnPos.x = 630 #0
	elif side == "C":
		spawnPos.x = 730
	else: #if side == "R":
		spawnPos.x = 830
	initNote1(spawnPos)
	
func spawnNote1():
	#print("current note: " + str(currentNote))
	if currentNote1 < song1.size() - 1:
		currentNote1 = currentNote1 + 1
	else:
		currentNote1 = 0
	var side = song1[currentNote1]
	#print("side: " + str(side))
	spawnNoteAtSide1(side)
	pass
	
func initNote2(spawnPos):
	#print("initialize it, do it now! " + str(spawnPos))
	var tempNote = note.instance()
	tempNote.position = spawnPos
	get_node("noteEmitter").add_child(tempNote)
	notes.append(tempNote)
	pass
	
func spawnNoteAtSide2(side):
	var spawnPos = Vector2()
	spawnPos.y = 50
	if side == "L":
		spawnPos.x = 110 #0
	elif side == "C":
		spawnPos.x = 210
	else: #if side == "R":
		spawnPos.x = 310
	initNote2(spawnPos)
	
func spawnNote2():
	#print("current note: " + str(currentNote))
	if currentNote2 < song2.size() - 1:
		currentNote2 = currentNote2 + 1
	else:
		currentNote2 = 0
	var side = song2[currentNote2]
	#print("side: " + str(side))
	spawnNoteAtSide2(side)
	pass

func _process(delta):
	#print("notes: " + str(notes))
	if Input.is_action_pressed("pause"):
		_pause()
	if Input.is_action_just_pressed("p1_move_left"):
		p1Left()
	elif Input.is_action_just_pressed("p1_move_right"):
		p1Right()
	if Input.is_action_just_pressed("p2_move_left"):
		p2Left()
	elif Input.is_action_just_pressed("p2_move_right"):
		p2Right()
	if time < tempo:
		time = time + 1
	else:
		time = 0
		#print("it's time")
		spawnNote1()
		spawnNote2()
	if notes.size() > 0:
		for i in range (0, notes.size() - 1):
			var nextNote = notes[i]
			if get_node("p1Catcher").overlaps_area(nextNote):
				p1Score = p1Score - 2
				p1streak = 0
				notes.remove(i)
				nextNote.destroy(false)
			elif get_node("p2Catcher").overlaps_area(nextNote):
				p2Score = p2Score - 2
				p2streak = 0
				notes.remove(i)
				nextNote.destroy(false)
			if nextNote.overlaps_area(player1):
				p1streak = p1streak + 1
				if p1streak > 30:
					p1Score = p1Score + 10
				elif p1streak > 20:
					p1Score = p1Score + 5
				elif p1streak > 10:
					p1Score = p1Score + 2
				else:
					p1Score = p1Score + 1
				notes.remove(i)
				nextNote.destroy(true)
			if nextNote.overlaps_area(player2):
				p2streak = p2streak + 1
				if p2streak > 30:
					p2Score = p2Score + 10
				elif p2streak > 20:
					p2Score = p2Score + 5
				elif p2streak > 10:
					p2Score = p2Score + 2
				else:
					p2Score = p2Score + 1
				notes.remove(i)
				nextNote.destroy(true)
			scoreLabel1.text = str(p1Score)
			scoreLabel2.text = str(p2Score)
			#print(str(p1Score))
	pass
