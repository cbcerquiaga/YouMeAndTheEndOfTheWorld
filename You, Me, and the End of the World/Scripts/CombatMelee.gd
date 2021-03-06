extends Area2D

var damage = 30 #default damage
var speed = 600 #default speed
var critChance = 0.25 #default chance of a critical hit
var bleed = 0 #default bleed damage
var ricochet = 0 #the number of times the bullet ricochets before destroying
var explosion = false #default explosiveness
var poison = false #default poison value
var isFacingRight = true
var velocity = Vector2()
var currentSpeed = 0
var rotationMod = 1

onready var enemyHealth = get_node("/root/Combat/CombatHUD/EnemyHealth")
onready var playerHealth = get_node("/root/Combat/CombatHUD/PlayerHealth")

onready var enemy = self.get_parent().get_node("../Enemy")

signal hit
signal hitUpdate

func _ready():
	set_process(true)
	if(!self.is_connected("hit", enemy, "_on_Bullet_hit")):
		self.connect("hit", enemy, "_on_Bullet_hit", [])
	self.connect("hitUpdate", enemyHealth, "hit", [])
	self.connect("hitUpdate", playerHealth, "hit", [])
	self.look_at(get_viewport().get_mouse_position())
	pass

func _process(delta):
	var collideCheck = get_overlapping_bodies()
	if(collideCheck != null):
		for i in collideCheck:
			print("Ouch!")
			contact(i)
	pass
	
func updateFacingRight(boolean):
	isFacingRight = boolean
	if isFacingRight:
		get_node("Sprite").set_flip_h(false)
	else:
		get_node("Sprite").set_flip_h(true)
		
func slashUp(speed):
	var wait = (100 - speed)/100
	for i in range (0, 10):
		yield(get_tree().create_timer(wait), "timeout")
		rotation = rotation + 0.25
	wait = (100 - speed/2)/98
	for i in range (0, 10):
		yield(get_tree().create_timer(wait), "timeout")
		rotation = rotation - 0.25
	pass
	
func slashDown(speed):
	var wait = (100 - speed)/100
	for i in range (0, 10):
		yield(get_tree().create_timer(wait), "timeout")
		rotation = rotation - 0.25
	wait = (100 - speed/2)/98
	for i in range (0, 10):
		yield(get_tree().create_timer(wait), "timeout")
		rotation = rotation + 0.25
	pass
	
func thrust(speed):
	pass
		

func contact(body):
	if Input.is_action_just_pressed("p2_action2") or Input.is_action_just_pressed("p2_move_right") or Input.is_action_just_pressed("Fkey"):
		print("Hit enemy")
		emit_signal("hit", body.name, damage, critChance)
		emit_signal("hitUpdate")
