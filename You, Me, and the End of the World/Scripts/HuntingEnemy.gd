extends KinematicBody2D

var velocity = Vector2()
const SPEED = 100
var velocityMultiplier = 1
var location #where the player-controlled hunter is

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func setHunterLocation(hunterLocation):
	location = hunterLocation
	
#feed this function "left" "right" "up" and "down"
func runDirection(direction):
	if direction == "left":
		velocity.x = -SPEED
	elif direction == "right":
		velocity.x = SPEED
	elif direction == "up":
		velocity.y = -SPEED
	else: #direction == "down":
		velocity.y = SPEED

func runDirectlyAway():
	#figure out which way would be directly away from the location
	if location.x - self.position.x <= -10: #leftward
		if location.y - self.position.y <= -10:
			#above and to the left, need to go SE
			velocity.x = SPEED
			velocity.y = SPEED
		elif location.y - self.position.y >= 10:
			#below and to the left, need to go NE
			velocity.x = SPEED
			velocity.y = -SPEED
		else: #basically equal in height
			#basically due left, need to go E
			velocity.x = SPEED
			velocity.y = 0
	elif location.x - self.position.x >= 10: #rightward
		if location.y - self.position.y <= -10:
			#above and to the right, need to go SW
			velocity.x = -SPEED
			velocity.y = SPEED
		elif location.y - self.position.y >= 10:
			#below and to the right, need to go NW
			velocity.x = -SPEED
			velocity.y = -SPEED
		else: #basically equal in height
			#basically due right, need to go W
			velocity.x = -SPEED
			velocity.y = 0
	else: #basically vertical
		if location.y > self.position.y: #above
			#basically above, need to go S
			velocity.x = 0
			velocity.y = SPEED
		else: #below or actually in the same place
			#basically below, need to go N
			velocity.x = 0
			velocity.y = -SPEED

func runAwayLeft():
	#figure out which way is left from there
	if location.x - self.position.x <= -10: #leftward
		if location.y - self.position.y <= -10:
			#above and to the left, need to go NE
			velocity.x = SPEED
			velocity.y = -SPEED
		elif location.y - self.position.y >= 10:
			#below and to the left, need to go NW
			velocity.x = -SPEED
			velocity.y = -SPEED
		else: #basically equal in height
			#basically due left, need to go N
			velocity.x = 0
			velocity.y = SPEED
	elif location.x - self.position.x >= 10: #rightward
		if location.y - self.position.y <= -10:
			#above and to the right, need to go SE
			velocity.x = SPEED
			velocity.y = SPEED
		elif location.y - self.position.y >= 10:
			#below and to the right, need to go SW
			velocity.x = -SPEED
			velocity.y = SPEED
		else: #basically equal in height
			#basically due right, need to go S
			velocity.x = 0
			velocity.y = SPEED
	else: #basically vertical
		if location.y > self.position.y: #above
			#basically above, need to go E
			velocity.x = SPEED
			velocity.y = 0
		else: #below or actually in the same place
			#basically below, need to go W
			velocity.x = -SPEED
			velocity.y = 0
	
#go 90 degrees to the right of running directly away
func runAwayRight():
	#figure out which way is right from there
	if location.x - self.position.x <= -10: #leftward
		if location.y - self.position.y <= -10:
			#above and to the left, need to go SW
			velocity.x = -SPEED
			velocity.y = SPEED
		elif location.y - self.position.y >= 10:
			#below and to the left, need to go SE
			velocity.x = SPEED
			velocity.y = SPEED
		else: #basically equal in height
			#basically due left, need to go S
			velocity.x = 0
			velocity.y = SPEED
	elif location.x - self.position.x >= 10: #rightward
		if location.y - self.position.y <= -10:
			#above and to the right, need to go NW
			velocity.x = -SPEED
			velocity.y = -SPEED
		elif location.y - self.position.y >= 10:
			#below and to the right, need to go NE
			velocity.x = SPEED
			velocity.y = -SPEED
		else: #basically equal in height
			#basically due right, need to go N
			velocity.x = 0
			velocity.y = SPEED
	else: #basically vertical
		if location.y > self.position.y: #above
			#basically above, need to go W
			velocity.x = -SPEED
			velocity.y = 0
		else: #below or actually in the same place
			#basically below, need to go E
			velocity.x = SPEED
			velocity.y = 0

func runTowards():
	#just do the opposite of runDirectlyAway
	runDirectlyAway(location)
	velocity.x = -velocity.x
	velocity.y = -velocity.y
	
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
	
func _process(delta):
	velocity.x = velocity.x * velocityMultiplier
	velocity.y = velocity.y * velocityMultiplier
	move_and_slide(velocity)
	pass