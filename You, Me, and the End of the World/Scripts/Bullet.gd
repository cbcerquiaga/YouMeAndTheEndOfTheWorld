extends KinematicBody2D

var damage = 10 #default damage
var spread = 5 #default spread
var speed = 500 #default speed
var bleed = 0 #default bleed damage
var ricochet = 0 #the number of times the bullet ricochets before destroying
var explosion = false #default explosiveness
var poison = false #default poison value
var motion = Vector2(2,0)
var gravity = Vector2(0, 500)

onready var enemy = self.get_parent().get_node("Enemy")
	
signal hit

func _ready():
	set_process(true)
	if(!self.is_connected("hit", enemy, "_on_Bullet_hit")):
		self.connect("hit", enemy, "_on_Bullet_hit", [])
	self.look_at(get_viewport().get_mouse_position())
	pass

func _process(delta):
	translate((speed * motion * delta))
	var collideCheck = move_and_collide(motion * delta* gravity)
	if(collideCheck != null):
		if(collideCheck.collider.name != "head" and collideCheck.collider.name != "torso"):
			print("Ouch!")
			#var enemy = get_node("/root/TileMap/Enemy")
			queue_free()
		else:
			contact(collideCheck.collider);
	pass
	
func contact(body):
	print("Hit enemy")
	emit_signal("hit", body.name, 10)
	#if ricochet < 1:
	destroy()

func destroy():
    #play explosion animation and sound
    queue_free()
