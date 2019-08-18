extends RigidBody2D

func _ready():
	gravity_scale = 0
	mass = .1
	friction = .2
	bounce = .5
	continuous_cd = CCD_MODE_CAST_SHAPE
	contact_monitor = true
	#set_contact_monitor(true)
	set_use_custom_integrator(false) 
	
func _process(delta):
	if contacts_reported > 0:
		linear_velocity.bounce(linear_velocity)
		print("contacts reported: " + str(contacts_reported))