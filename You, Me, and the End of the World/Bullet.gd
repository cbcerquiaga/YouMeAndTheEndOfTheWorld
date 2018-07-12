extends RigidBody2D

var damage = 10 #default damage
var spread = 5 #default spread
var speed = 100 #default speed
var bleed = 0 #default bleed damage
var ricochet = 0 #the number of times the bullet ricochets before destroying
var explosion = false #default explosiveness
var poison = false #default poison value
	
func _ready():
	#set_fixed_process(true)
	#set_contact_monitor(true)
	pass

func shoot(var matrix):
    set_transform(matrix)
    #set_linear_velocity(vel)
	
func contact(body):
    if body.is_in_group("Enemy"):
        emit_signal("hit", body, damage)
	#if ricochet < 1:
    destroy()

func destroy():
    #play explosion animation and sound
    queue_free()
	
