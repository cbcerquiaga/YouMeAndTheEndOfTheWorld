extends RigidBody2D

onready var isHeld #if the ball is held, it can be thrown. If not, it's free
var holdingPlayer
var isGoingRight

const minPower = 500
const maxPower = 1000
const goalPower = 798 #tested that this is the best power for getting the ball in the hoop most of the time

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_bounce(.6)
	self.mass = 1.2
	self.friction = 1
	isHeld = false
	pass
	
func shoot_ball():
	var mousePos = get_local_mouse_position()
	var trueMousePos = mousePos
	var selfPos = self.get_global_position()
	var power = abs(selfPos.distance_to(mousePos))
	power = (power + goalPower)/2 #normalize power
	if power > maxPower:
		power = maxPower
	elif power < minPower:
		power = minPower
	#add spread to mouse position
	var randSpread = int(rand_range(-holdingPlayer.spread,holdingPlayer.spread))
	mousePos.x += randSpread
	randSpread = int(rand_range(-holdingPlayer.spread,holdingPlayer.spread))
	mousePos.y += randSpread
	#find angle
	self.look_at(trueMousePos)
#	var angle = selfPos.angle_to(mousePos)
#	var offset = Vector2(cos(angle), sin(angle))
	#launch the ball
	isHeld = false
	holdingPlayer.canCatchBall = false
	print(" power: " + str(power))
	apply_impulse(Vector2(mousePos.x,mousePos.y),Vector2 (0, power).rotated(rotation))
	set_applied_torque(0)
	
func timeout():
	rotation = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if isHeld:
		self.position.x = holdingPlayer.holdArea.global_position.x
		self.position.y = holdingPlayer.holdArea.global_position.y
		if Input.is_action_just_pressed("click") and !holdingPlayer.isMouseNull:
			shoot_ball()
			#short delay, then stop spinning
			yield(get_tree().create_timer(0.5), "timeout")
	#if mouse clicked and isHeld:
		#check mouse position
		#get distance from ball
		#turn distance into force quantity
		#get angle from ball
		#apply_force(angle, force)
		#isHeld = false
	#if held but not clicked:
		#snap to position for heldPlayer
	else:
		#check if bounced
		if contacts_reported > 0:
			if holdingPlayer != null:
				holdingPlayer.canHoldBall = true
		#check if close enough to be held
			#if yes, set held to be true
	pass
