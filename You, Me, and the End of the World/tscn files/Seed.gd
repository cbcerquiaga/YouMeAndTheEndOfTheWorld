extends KinematicBody2D

onready var motion = Vector2(0,0)
onready var speed = 300
onready var remainingTime = 40
var affectedPlot

func _ready():
	affectedPlot = "0-0"
	pass
	
func affectPlot():
	#print(str(hoePos))
	if position.x > 255 and position.x < 780: #in-bounds x-wise, trying to save the computer from having to do all these conditionals if it doesn't have to
		if position.y > 231.6 and position.y < 306.6: #first row
			if position.x < 330:
				affectedPlot = "1-1"
			elif position.x < 405:
				affectedPlot = "2-1"
			elif position.x < 480:
				affectedPlot = "3-1"
			elif position.x < 555:
				affectedPlot = "4-1"
			elif position.x < 630:
				affectedPlot = "5-1"
			elif position.x < 705:
				affectedPlot = "6-1"
			else: #if position.x < 780:
				affectedPlot = "7-1"
		elif position.y > 306.6 and position.y < 381.6: #second row
			if position.x < 330:
				affectedPlot = "1-2"
			elif position.x < 405:
				affectedPlot = "2-2"
			elif position.x < 480:
				affectedPlot = "3-2"
			elif position.x < 555:
				affectedPlot = "4-2"
			elif position.x < 630:
				affectedPlot = "5-2"
			elif position.x < 705:
				affectedPlot = "6-2"
			else: #if position.x < 780
				affectedPlot = "7-2"
		elif position.y > 381.6 and position.y < 456.6: #third row
			if position.x < 330:
				affectedPlot = "1-3"
			elif position.x < 405:
				affectedPlot = "2-3"
			elif position.x < 480:
				affectedPlot = "3-3"
			elif position.x < 555:
				affectedPlot = "4-3"
			elif position.x < 630:
				affectedPlot = "5-3"
			elif position.x < 705:
				affectedPlot = "6-3"
			else: #if position.x < 780
				affectedPlot = "7-3"
		elif position.y > 456.6 and position.y < 531.6: #fourth row
			if position.x < 330:
				affectedPlot = "1-4"
			elif position.x < 405:
				affectedPlot = "2-4"
			elif position.x < 480:
				affectedPlot = "3-4"
			elif position.x < 555:
				affectedPlot = "4-4"
			elif position.x < 630:
				affectedPlot = "5-4"
			elif position.x < 705:
				affectedPlot = "6-4"
			else: #if position.x < 780
				affectedPlot = "7-4"

func _process(delta):
	#translate((speed * motion * delta))
	move_and_slide(Vector2(motion.x*speed,motion.y*speed))
	remainingTime = remainingTime - 1
	if remainingTime == 0:
		speed = 0
	if remainingTime < 5: #5 cycles after running out of time
		affectPlot()
	pass