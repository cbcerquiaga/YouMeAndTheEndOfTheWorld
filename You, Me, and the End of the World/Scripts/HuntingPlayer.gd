extends KinematicBody2D

var velocity = Vector2()
var ammoVal = 0
const SPEED = 600
onready var lostVal = 0
onready var spookVal = 0
onready var shotVal = 0#100
var spread = 20
onready var bulletsFired = []
onready var bullet = load("res://tscn files/HuntingBullet.tscn")
var creature

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func setCreature(newCreature):
	creature = newCreature

func create_bullet(position):
	var tempBullet = bullet.instance()
	tempBullet.set_speed(500)
	tempBullet.set_position(self.position)
	var truePosition = get_local_mouse_position()
	truePosition.x += 15
	truePosition.y += 15
	#add spread based on bullet type
	var randSpread = int(rand_range(-spread,spread))
	truePosition.x += randSpread
	randSpread = int(rand_range(-spread,spread))
	truePosition.y += randSpread
	tempBullet.motion = truePosition.normalized()
	self.get_parent().add_child(tempBullet)
	tempBullet.creature = creature
	bulletsFired.append(tempBullet)
	
func checkAndKillBullets():
	for i in range(0, bulletsFired.size() - 1):
		var tempBullet = bulletsFired[i]
		if tempBullet.distance > tempBullet.maxDistance:
			tempBullet.destroy()

func _process(delta):
	if lostVal < 0:
		lostVal = 0
	if spookVal < 0:
		spookVal = 0
	if shotVal < 0:
		shotVal = 0
	if Input.is_action_pressed("p1_move_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("p1_move_left"):
		velocity.x = -SPEED
	elif !Input.is_action_pressed("p1_move_right") and !Input.is_action_pressed("p1_move_left"): #neither is pressed
		velocity.x = 0
	if Input.is_action_pressed("p1_move_up"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("p1_move_down"):
		velocity.y = SPEED
	elif !Input.is_action_pressed("p1_move_up") and !Input.is_action_pressed("p1_move_down"): #neither is pressed
		velocity.y = 0
	if shotVal >= 100:
		if Input.is_action_just_pressed("click"):
			shotVal = 0
			create_bullet(self.position)
	move_and_slide(velocity)
	checkAndKillBullets()
	pass
