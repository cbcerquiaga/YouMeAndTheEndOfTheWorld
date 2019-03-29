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
onready var note0 = get_node("p1Arranger/MusicKey")
onready var note1 = get_node("p1Arranger/MusicKey2")
onready var note2 = get_node("p1Arranger/MusicKey3")
onready var note3 = get_node("p1Arranger/MusicKey4")
onready var note4 = get_node("p1Arranger/MusicKey5")
onready var note5 = get_node("p1Arranger/MusicKey6")
onready var note6 = get_node("p1Arranger/MusicKey7")
onready var note7 = get_node("p1Arranger/MusicKey8")


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
		note0.changeTexture(keyArray[currentKey],1)
	elif note == 1:
		note1.changeTexture(keyArray[currentKey],1)
	elif note == 2:
		note2.changeTexture(keyArray[currentKey],1)
	elif note == 3:
		note3.changeTexture(keyArray[currentKey],1)
	elif note == 4:
		note4.changeTexture(keyArray[currentKey],1)
	elif note == 5:
		note5.changeTexture(keyArray[currentKey],1)
	elif note == 6:
		note6.changeTexture(keyArray[currentKey],1)
	else: #if note == 7:
		note7.changeTexture(keyArray[currentKey],1)
	
func setWaiting(note):
	if note == 0:
		note0.wait()
	elif note == 1:
		note1.wait()
	elif note == 2:
		note2.wait()
	elif note == 3:
		note3.wait()
	elif note == 4:
		note4.wait()
	elif note == 5:
		note5.wait()
	elif note == 6:
		note6.wait()
	else: #if note == 7:
		note7.wait()
		
func go(note):
	if note == 0:
		note0.go()
	elif note == 1:
		note1.go()
	elif note == 2:
		note2.go()
	elif note == 3:
		note3.go()
	elif note == 4:
		note4.go()
	elif note == 5:
		note5.go()
	elif note == 6:
		note6.go()
	else: #if note == 7:
		note7.go()

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
	setWaiting(1)
	go(1)
	if time >= tempo:
		nextNote()
		time = 0
	else:
		time = time+1
	pass
	
