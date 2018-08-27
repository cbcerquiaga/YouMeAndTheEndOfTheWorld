extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var player1 = get_node("/root/Root/walls/player1")
onready var player2 = get_node("/root/Root/walls/player2")
var screensize
var zoomOutThreshold = 600
var zoomOutMax = 1.5
var isZoomedOut = false

func _ready():
#	$Camera.zoom = Vector2(1.0, 1.0)
	pass

func _process(delta):
	screensize = get_viewport().get_visible_rect().size
	var distance = (player1.position - player2.position)
	var distanceInInt = distance.length()
	#print(distanceInInt)
	if(distanceInInt > zoomOutThreshold):
		var zoomOutFactor = ((distanceInInt - zoomOutThreshold)/100) + 1
		if(zoomOutFactor > zoomOutMax):
			zoomOutFactor = zoomOutMax
		$Camera.zoom = Vector2(zoomOutFactor, zoomOutFactor)
		isZoomedOut = true
	else:
		$Camera.zoom = Vector2(1,1)
		isZoomedOut = false
	self.position = ((player1.position + player2.position)/(2))
	pass
