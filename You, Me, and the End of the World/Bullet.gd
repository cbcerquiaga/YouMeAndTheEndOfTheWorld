extends KinematicBody2D

var damage = 10 #default damage
var spread = 5 #default spread
var speed = 500 #default speed
var bleed = 0 #default bleed damage
var ricochet = 0 #the number of times the bullet ricochets before destroying
var explosion = false #default explosiveness
var poison = false #default poison value
var motion = Vector2(2,0)
	
func _ready():
	set_process(true)
	pass

func _process(delta):
	translate(speed * motion * delta)
	var collideCheck = move_and_collide(motion)
	if(collideCheck != null):
		print("Ouch!")
		#var enemy = get_node("/root/TileMap/Enemy")
		queue_free()
	pass
	
func contact(body):
	if body.is_in_group("Enemy"):
		emit_signal("hit", body, damage)
	#if ricochet < 1:
	destroy()

func destroy():
    #play explosion animation and sound
    queue_free()
