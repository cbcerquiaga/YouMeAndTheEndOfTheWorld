extends KinematicBody2D

var velocity = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func runDirectlyAway(location):
	#figure out which way would be directly away from the location
	if location.x - self.position.x <= -10: #leftward
		if location.y - self.position.y <= -10:
			print("above and to the left, need to go SE")
		elif location.y - self.position.y >= 10:
			print("below and to the left, need to go NE")
		else: #basically equal in height
			print("basically due left, need to go E")
	elif location.x - self.position.x >= 10: #rightward
		if location.y - self.position.y <= -10:
			print("above and to the right, need to go SW")
		elif location.y - self.position.y >= 10:
			print("below and to the right, need to go NW")
		else: #basically equal in height
			print("basically due right, need to go W")
	else: #basically vertical
		if location.y > self.position.y: #above
			print("basically above, need to go S")
		else: #below or actually in the same place
			print("basically below, need to go N")
	print("move directly away from the location")

func runAwayLeft(location):
	#figure out which way is left from there
	if location.x - self.position.x <= -10: #leftward
		if location.y - self.position.y <= -10:
			print("above and to the left, need to go NE")
		elif location.y - self.position.y >= 10:
			print("below and to the left, need to go NW")
		else: #basically equal in height
			print("basically due left, need to go N")
	elif location.x - self.position.x >= 10: #rightward
		if location.y - self.position.y <= -10:
			print("above and to the right, need to go SE")
		elif location.y - self.position.y >= 10:
			print("below and to the right, need to go SW")
		else: #basically equal in height
			print("basically due right, need to go S")
	else: #basically vertical
		if location.y > self.position.y: #above
			print("basically above, need to go E")
		else: #below or actually in the same place
			print("basically below, need to go W")
	#go left
	print("move hard to the left from my current location and direction")
	
#go 90 degrees to the right of running directly away
func runAwayRight(location):
	#figure out which way is right from there
	if location.x - self.position.x <= -10: #leftward
		if location.y - self.position.y <= -10:
			print("above and to the left, need to go SW")
		elif location.y - self.position.y >= 10:
			print("below and to the left, need to go SE")
		else: #basically equal in height
			print("basically due left, need to go S")
	elif location.x - self.position.x >= 10: #rightward
		if location.y - self.position.y <= -10:
			print("above and to the right, need to go NW")
		elif location.y - self.position.y >= 10:
			print("below and to the right, need to go NE")
		else: #basically equal in height
			print("basically due right, need to go N")
	else: #basically vertical
		if location.y > self.position.y: #above
			print("basically above, need to go W")
		else: #below or actually in the same place
			print("basically below, need to go E")

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