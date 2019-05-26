extends Node

#these keep track of the current and next key presses for each player
var tempo = 10 #time between note spawns
var time #tracks time for tempo
var song #the actual song being played
var currentNote = 0 #index in the song where we are now
#var loops = 2 #number of times we loop through the song before completion
var defaultSong = ["L","C","L","R","C","R"] #default song if song isn't changed
var p1Score = 0
var p2Score = 0
onready var p1Pos = "L"
onready var p2Pos = "C"
onready var note = load("res://tscn files/MusicKey.tscn")
onready var player1 = get_node("player1")
#onready var player2 = get_node("player2")
var notes #array of all notes

func _ready():
	time = 0
	song = defaultSong
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
		#change x to left
	elif p2Pos == "R":
		p2Pos = "C"
		#change x to center
		
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
		#change x to right
	elif p2Pos == "L":
		p2Pos = "C"
		#change x to center
	
func initNote(spawnPos):
	print("initialize it, do it now! " + str(spawnPos))
	var tempNote = note.instance()
	tempNote.position = spawnPos
	notes.append(tempNote)
	pass
	
func spawnNoteAtSide(side):
	var spawnPos = Vector2()
	spawnPos.y = 50
	if side == "L":
		spawnPos.x = 630 #0
	elif side == "C":
		spawnPos.x = 730
	else: #if side == "R":
		spawnPos.x = 830
	initNote(spawnPos)
	
func spawnNote():
	#print("current note: " + str(currentNote))
	if currentNote < song.size() - 1:
		currentNote = currentNote + 1
	else:
		currentNote = 0
	var side = song[currentNote]
	#print("side: " + str(side))
	spawnNoteAtSide(side)
	pass

func _process(delta):
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
		spawnNote()
	pass
