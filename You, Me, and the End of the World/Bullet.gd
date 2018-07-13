extends RigidBody2D

var damage = 10 #default damage
var spread = 5 #default spread
var speed = 100 #default speed
var bleed = 0 #default bleed damage
var ricochet = 0 #the number of times the bullet ricochets before destroying
var explosion = false #default explosiveness
var poison = false #default poison value
var motion = Vector2(2,0)
	
func _ready():
	set_process(true)
	queue_free()
	pass

func _process(delta):
	translate(motion * delta)
	pass
	
func contact(body):
    if body.is_in_group("Enemy"):
        emit_signal("hit", body, damage)
	#if ricochet < 1:
    destroy()

func destroy():
    #play explosion animation and sound
    queue_free()
