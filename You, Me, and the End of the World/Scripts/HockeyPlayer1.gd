extends RigidBody2D

var power = 0
var tf
var vel

func process(delta):
	tf = self.get_global_transform()
	vel = self.get_linear_velocity()
	if Input.is_action_pressed("p1_move_up"):
		power = 1
	elif Input.is_action_pressed("p1_move_down"):
		power = -0.5
	elif !Input.is_action_pressed("p1_move_up") and !Input.is_action_pressed("p1_move_down"):
		power = 0
	if Input.is_action_pressed("p1_move_left"):
		self.rotation -= 10
	elif Input.is_action_pressed("p1_move_right"):
    	self.rotation+= 10
	else: #niether left or right
		self.rotation  = 0
	
	apply_impulse(Vector2(), tf.basis_xform(Vector2(0, power)))