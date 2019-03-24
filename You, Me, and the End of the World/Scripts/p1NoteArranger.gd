extends Node2D
#instead of spawning notes, this node takes a series of pre-existing nodes
#and rearranges them as the minigame plays.

var keyArray
var notesArray
var leadNote
var currentKey
var numNotesOnscreen
var tempo
var time


func _ready():
	keyArray = ["A"]#default song
	initNotesArray(8)
	leadNote = 0
	numNotesOnscreen = 0
	tempo = 10
	currentKey = 0
	time = 0
	pass

func pasSong(song):
	keyArray = song
	
func changeTexture(note):
	if note == 0:
		get_node("p1Arranger/MusicKey").changeTexture(keyArray[currentKey],1)
	elif note == 1:
		get_node("p1Arranger/MusicKey2").changeTexture(keyArray[currentKey],1)
	elif note == 2:
		get_node("p1Arranger/MusicKey3").changeTexture(keyArray[currentKey],1)
	elif note == 3:
		get_node("p1Arranger/MusicKey4").changeTexture(keyArray[currentKey],1)
	elif note == 4:
		get_node("p1Arranger/MusicKey5").changeTexture(keyArray[currentKey],1)
	elif note == 5:
		get_node("p1Arranger/MusicKey6").changeTexture(keyArray[currentKey],1)
	elif note == 6:
		get_node("p1Arranger/MusicKey7").changeTexture(keyArray[currentKey],1)
	else: #if note == 7:
		get_node("p1Arranger/MusicKey8").changeTexture(keyArray[currentKey],1)
	
func setWaiting(note, val):
	if note == 0:
		get_node("p1Arranger/MusicKey").waiting = val
	elif note == 1:
		get_node("p1Arranger/MusicKey2").waiting = val
	elif note == 2:
		get_node("p1Arranger/MusicKey3").waiting = val
	elif note == 3:
		get_node("p1Arranger/MusicKey4").waiting = val
	elif note == 4:
		get_node("p1Arranger/MusicKey5").waiting = val
	elif note == 5:
		get_node("p1Arranger/MusicKey6").waiting = val
	elif note == 6:
		get_node("p1Arranger/MusicKey7").waiting = val
	else: #if note == 7:
		get_node("p1Arranger/MusicKey8").waiting = val

func setTempo(val):
	tempo = val
	
func initNotesArray(numNotes):
	notesArray = [get_node("p1Arranger/MusicKey"), get_node("p1Arranger/MusicKey2"), get_node("p1Arranger/MusicKey3"), get_node("p1Arranger/MusicKey4"), get_node("p1Arranger/MusicKey5"), get_node("p1Arranger/MusicKey6"), get_node("p1Arranger/MusicKey7"), get_node("p1Arranger/MusicKey8")]

func nextNote():
	if numNotesOnscreen == 0:#first note
		#changeTexture(leadNote)
		#setWaiting(leadNote,false)
		#notesArray[leadNote].changeTexture(keyArray[currentKey])
		#notesArray[leadNote].waiting = false
		pass

func _process(delta):
	if time >= tempo:
		nextNote()
		time = 0
	else:
		time = time+1
	pass
	
