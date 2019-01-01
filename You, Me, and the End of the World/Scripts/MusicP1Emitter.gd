extends Node2D

onready var note = load("res://tscn files/MusicKey.tscn")
var tempo = 10
var time
var song
var defaultSong = ["A","D","A","D","W","S"]
#maybe we ought to have a tempoArray as well?
var currentNote = 0
var mostRecentNote = ""

func _ready():
	time = 0
	song = defaultSong #unless otherwise specified
	pass
	
#make sure every note is a capitalized single letter string, either "A", "S", "D", of "W"
func changeSong(songArray):
	song = songArray
	
#pass an integer here
func changeTempo(tempoVal):
	tempo = tempoVal
	
func spawnNote():
	if currentNote < song.size() - 1:
		currentNote = currentNote + 1
	else:
		currentNote = 0
	var noteVal = song[currentNote]
	mostRecentNote = noteVal
	#print("Note: " + str(noteVal))
	var tempNote = note.instance()
	tempNote.set_position(self.position)
	#tempNote.changeTexture(noteVal, 1)
	

#func _process(delta):
#	if time >= tempo:
#		spawnNote()
#		time = 0
#	else:
#		time = time+1
#		print(str(time))
#	pass
