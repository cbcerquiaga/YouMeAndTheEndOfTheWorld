extends KinematicBody2D

var damage = 45 #default damage
var speed = 1600 #default speed
var critChance = 0.05 #default chance of a critical hit
var bleed = 0 #default bleed damage
var ricochet = 0 #the number of times the bullet ricochets before destroying
var explosion = false #default explosiveness
var poison = false #default poison value
var motion = Vector2(2,0)

onready var enemyHealth = get_node("/root/Combat/CombatHUD/EnemyHealth")
onready var playerHealth = get_node("/root/Combat/CombatHUD/PlayerHealth")

onready var player = self.get_parent().get_node("CombatPlayer")

signal hit
signal hitUpdate

func _ready():
	set_process(true)
	if(!self.is_connected("hit", player, "_on_Bullet_hit")):
		self.connect("hit", player, "_on_Bullet_hit", [])
	self.connect("hitUpdate", enemyHealth, "hit", [])
	self.connect("hitUpdate", playerHealth, "hit", [])
	pass

func _process(delta):
	translate((speed * motion * delta))
	var collideCheck = move_and_collide(motion * delta)
	if(collideCheck != null):
		if(collideCheck.collider.name != "head" and collideCheck.collider.name != "torso"):
			print("Ouch!")
			hide()
			queue_free()
		else:
			contact(collideCheck.collider);
	pass

func contact(body):
	print("Hit player")
	emit_signal("hit", body.name, damage, critChance)
	emit_signal("hitUpdate")
	#if ricochet < 1:
	destroy()

func destroy():
    #play explosion animation and sound
    queue_free()
