extends Node

#these keep track of the current and next key presses for each player
var keyArray1 = []
var keyArray2 = []
var tempo = 10
var time
var song
var defaultSong = ["A","D","A","D","W","S"]
onready var emitter1 = get_node("p1Emitter")
onready var emitter2 = get_node("p2Emitter")

func _ready():
	time = 0
	emitter1.changeSong(defaultSong)
	#emitter2.changeSong(defaultSong)
	pass

func _process(delta):
	if Input.is_action_just_pressed("p2_move_left"):
		if keyArray1[0] == "A":
			print("nice")
		else:
			print("not nice")
	if time >= tempo:
		emitter1.spawnNote()
		keyArray1.append(emitter1.mostRecentNote)
		#emitter2.spawnNote()
		#keyArray2.append(emitter2.mostRecentNote)
		time = 0
	else:
		time = time+1
		print(str(time))
	pass