extends KinematicBody2D

var velocity = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func runDirectlyAway(location):
	#figure out which way would be directly away from the location
	print("move directly away from the location")

func runAwayLeft(location):
	#check direction
	#figure out which way is left from there
	#go left
	print("move hard to the left from my current location and direction")
	
func runAwayRight(location):
	#check direction
	#figure out which way is right from there
	#go right
	print("move hard to the right from my current location and direction")

func runTowards(location):
	#figure out which way will go towards the location
	#go that way
	print("come at me bro")
	
func getJitter():
	var returnArray = []
	var randDirection = ""
	var randTime = 0
	returnArray[0] = randDirection
	returnArray[1] = randTime
	return returnArray
	
#pass in values from the array in getJitter()
func exectuteJitter(direction, time):
	if time > 0:
		executeJitter(direction, time-1)
	else: #time == 0 or there was a problem
		print("go in " + direction)
		
func jitter():
	var array = getJitter()
	executeJitter(array[0], array[1])