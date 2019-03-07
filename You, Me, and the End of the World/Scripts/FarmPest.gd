extends "res://Scripts/Hunting AI/HuntingEnemy.gd"

var state
var plots
var circleDirection
const SPEED = 20
var moveTime = 61
var lastMove
var distances = [60, 20]

func _ready():
	state = "searching"
	var coin = randi()%2
	if coin == 1:
		circleDirection = "clock"
	else:
		circleDirection = "counter"
	pass
	
func setPlots(newPlots):
	plots = newPlots
	
func lookForFood():
	
	circlePlots()
	pass
	
func circlePlots():
	if circleDirection == "clock":#circle clockwise
		clockwise()
	else: #circleDirection == "counter"
		counterClockwise()#circle counterclockwise
		
#modified from spiralPatternAnimal
func counterClockwise():
	if moveTime < 0:
		#move counterclockwise either a short or long distance
		if lastMove == "up":
			runDirection("left")
			lastMove = "left"
			moveTime = distances[0]#go long
		elif lastMove == "left":
			runDirection("down")
			lastMove = "down"
			moveTime = distances[1]#go short
		elif lastMove == "down":
			runDirection("right")
			lastMove = "right"
			moveTime = distances[0]#go long
		else: #if lastMove == "right":
			runDirection("up")
			lastMove = "up"
			moveTime = distances[1]#go short
	elif moveTime > 60: #first move
		runDirection("right")
		lastMove = "right"
		moveTime = moveTime - 1
	else:
		if lastMove == "up":
			runDirection("up")
		elif lastMove == "left":
			runDirection("left")
		elif lastMove == "down":
			runDirection("down")
		else: #if lastMove == "right":
			runDirection("right")
		moveTime = moveTime - 1
		
func clockwise():
	if moveTime < 0:
		#move counterclockwise either a short or long distance
		if lastMove == "up":
			runDirection("right")
			lastMove = "right"
			moveTime = distances[0]#go long
		elif lastMove == "right":
			runDirection("down")
			lastMove = "down"
			moveTime = distances[1]#go short
		elif lastMove == "down":
			runDirection("left")
			lastMove = "left"
			moveTime = distances[0]#go long
		else: #if lastMove == "left":
			runDirection("up")
			lastMove = "up"
			moveTime = distances[1]#go short
	elif moveTime > 60: #first move
		runDirection("right")
		lastMove = "right"
		moveTime = moveTime - 1
	else:
		if lastMove == "up":
			runDirection("up")
		elif lastMove == "left":
			runDirection("left")
		elif lastMove == "down":
			runDirection("down")
		else: #if lastMove == "right":
			runDirection("right")
		moveTime = moveTime - 1
	pass
	
func huntDownTheFood():
	pass

func _process(delta):
	#the hoe is too close, need to run
	if location.x - position.x < 60 and location.x - position.x > -60:
		if location.y - position.y < 60 and location.y - position.y > -60:
			state = "running"
	if state == "searching":
		lookForFood()
	elif state == "running":
		runDirectlyAway()
	elif state == "tracking":
		huntDownTheFood()
	pass
