extends RigidBody2D

func _ready():
	gravity_scale = 0
	mass = .1
	friction = .2
	bounce = .5
	continuous_cd = CCD_MODE_CAST_SHAPE
	
func _process(delta):
	print("contacts reported: " + str(contacts_reported))